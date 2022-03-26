from api.models import Restaurant, Donations
from geopy import units, distance
from geopy.geocoders import Nominatim
from django.contrib.gis.measure import D
from django.contrib.gis.geos import *
import math

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
    return distance


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