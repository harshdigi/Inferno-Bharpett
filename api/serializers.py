from dataclasses import field
from rest_framework import serializers
from utils import helper
from . import models

class RestaurantSerializer(serializers.ModelSerializer):

    Distance = serializers.SerializerMethodField()
    
    class Meta:
        model = models.Restaurant
        fields = [
            "RestaurantID", "RestaurantName", "CountryCode", "City", "Address",
            "Locality", "LocalityVerbose", "Longitude", "Latitude", "Cuisines",
            "Address", "AverageCostForTwo", "Currency", "PriceRange", 
            "AggregateRating", "Votes", "Distance"
        ]

    def get_Distance(self, obj):
        user_latitude = self.context.get("Latitude")
        user_longitude = self.context.get("Longitude")
        distance = helper.distanceCalc(float(user_latitude), float(user_longitude), float(obj.Latitude), float(obj.Longitude))
        return "{:.2f}".format(distance*111)


class RestaurantSerializerFirebase(serializers.ModelSerializer):
    pass