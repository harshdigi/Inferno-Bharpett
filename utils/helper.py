from api.models import Restaurant
from geopy import units, distance
from geopy.geocoders import Nominatim
from django.contrib.gis.measure import D
from django.contrib.gis.geos import *

# latitude=23.37498889 , longitude=85.33548611
def get_nearby_restaurants(latitude , longitude, distance_range=10):

    lat = float(latitude)
    lon = float(longitude)
    distance_range = float(distance_range)
    
    # pnt = fromstr('POINT(48.796777 2.371140 )', srid=4326)
    # query = Restaurant.objects.filter(point__distance_lte=(pnt, D(km=20)))
    
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

    return query
