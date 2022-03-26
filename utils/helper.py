from api.models import Restaurant, Donations
from geopy import units, distance
from geopy.geocoders import Nominatim
from django.contrib.gis.measure import D
from django.contrib.gis.geos import *
import math
import heapq as hp

# latitude=23.37498889 , longitude=85.33548611
def get_nearby_restaurants(latitude , longitude, distance_range=10):

    lat = float(latitude)
    lon = float(longitude)
    distance_range = float(distance_range)
    rough_distance = units.degrees(arcminutes=units.nautical(kilometers=distance_range)) * 2

    query = Restaurant.objects.filter(
        Latitude__range=(
            latitude - rough_distance,
            latitude + rough_distance
        ),
        Longitude__range=(
            longitude - rough_distance,
            longitude + rough_distance
        )
    )

    if query:
        return query
    else:
        return None


def distanceCalc(userlat:float, userlong:float, restlat:float, restlong:float):
    distance = math.sqrt( ((userlat - restlat)**2) + ((userlong - restlong)**2) )
    return distance*111


def get_nearby_donations(latitude , longitude, distance_range=10):
    lat = float(latitude)
    lon = float(longitude)
    distance_range = float(distance_range)
    rough_distance = units.degrees(arcminutes=units.nautical(kilometers=distance_range)) * 2

    query = Donations.objects.filter(
        latitude__range=(
            latitude - rough_distance,
            latitude + rough_distance
        ),
        longitude__range=(
            longitude - rough_distance,
            longitude + rough_distance
        )
    )

    if query:
        return query
    else:
        return None


    import heapq as hp


def recommendations(maxheap:list)->list:
    """
        Takes a list containing the ratings of the restaurants,
        and returns a list sorted using mapHeap Algorithm.
    """
    hp._heapify_max(maxheap)

    """
    When a request is to be for recommending a restaurant, perform pop operation
    on maxheap.

    """
    return maxheap
    

def priorityImp(scaledData):
    rest_rating_lst = []
    for restinfo in scaledData:
        restId = list(restinfo.keys())[0]
        cost, rating, votes, dist = restinfo[restId][:]
        rating_value = 0.3 * (1 - cost) + 0.25 * rating + 0.1 * votes + 0.35 * (1 - dist)
        rest_rating_lst.append( (rating_value, restId) )
    return rest_rating_lst


def scaling_data(rawRest_data:list)->list:
    restid_lst, avg_cost_lst, rating_lst, votes_lst, dist_lst = [], [], [], [], []
    minmaxMean_lst = []
    
    for rest_info in rawRest_data:
        restid_lst.append(rest_info.get("RestaurantID"))
        avg_cost_lst.append(float(rest_info.get("AverageCostForTwo")))
        rating_lst.append(float(rest_info.get("AggregateRating")))
        votes_lst.append(float(rest_info.get("Votes")))
        dist_lst.append(float(rest_info.get("Distance")))
    for lst in [avg_cost_lst, rating_lst, votes_lst, dist_lst]:
        minmaxMean_lst.append((min(lst), max(lst)))
        
    return [avg_cost_lst, rating_lst, votes_lst, dist_lst, minmaxMean_lst, restid_lst]


def featureScaling(avg_cost_lst:list, rating_lst:list, votes_lst:list, dist_lst:list, meanStd_lst:list, restid_lst:list)-> list:
    """
        Implements scaling on the data so that all the features 
        are in the same scale/range of value.
        We use min and max value which is calculated based on the 
        entire column of the dataset, to perform mean normalisation of data

        Input:
        meanStd_lst: Output of scaling_data(), contains min and max of all values.
                    order => cost, rating, votes, distance

        Output: List of scaled values
    """

    scaled_data = []
    for (cost, rating, popularity, dist, restid) in zip(avg_cost_lst, rating_lst, votes_lst, dist_lst, restid_lst):
        normCost = ( cost - meanStd_lst[0][0]) / (meanStd_lst[0][1] - meanStd_lst[0][0])
        normRating = ( rating - meanStd_lst[1][0]) / (meanStd_lst[1][1] - meanStd_lst[1][0])
        normPopul = ( popularity - meanStd_lst[2][0]) / (meanStd_lst[2][1] - meanStd_lst[2][0])
        normDist = ( dist - meanStd_lst[3][0]) / (meanStd_lst[3][1] - meanStd_lst[3][0])
        scaled_data.append({restid: [normCost, normRating, normPopul, normDist]})

    return scaled_data