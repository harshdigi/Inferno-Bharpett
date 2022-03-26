from logging import exception
from traceback import print_tb
from django.shortcuts import render
from django.views import View

# REST FRAMEWORK
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from rest_framework.pagination import PageNumberPagination

from . import serializers, models
from utils import helper
import heapq as hp

from extensions.handlers import SuccessResponse, FailureResponse


class TestView(ViewSet):

    def test(self, request):
        return SuccessResponse('Working').response()
        

class RestaurantView(ViewSet):

    def get_all_restaurants(self, request):
        data = request.data
        latitude = data.get("latitude")
        longitude = data.get("longitude")

        if not latitude or not longitude:
            return FailureResponse('Error Fetching Latitude/Longitude', 400).response()

        query = helper.get_nearby_restaurants(latitude=float(latitude), longitude=float(longitude))
        if query is not None:
            paginator = PageNumberPagination()
            paginator.page_size = 10
            result = paginator.paginate_queryset(query, request)
            context = {
                "Latitude": float(latitude),
                "Longitude": float(longitude)
            }
            serializer = serializers.RestaurantSerializer(result, many=True, context=context)
            return paginator.get_paginated_response(serializer.data)
        return FailureResponse('No Restaurants available in your area', 400).response()


    def get_single_restaurant(self, request, id):
        query = models.Restaurant.objects.filter(id=id).first()
        if query:
            context = {
                "Latitude": 0,
                "Longitude": 0
            }
            serializer = serializers.RestaurantSerializer(query, many=False, context=context)
            return SuccessResponse(serializer.data).response()
        return FailureResponse('Restaurant Not Found', 404).response()


    def get_recommended_restaurants(self, request):
        data = request.data
        latitude = data.get("latitude")
        longitude = data.get("longitude")

        if not latitude or not longitude:
            return FailureResponse('Error Fetching Latitude/Longitude', 400).response()

        query = helper.get_nearby_restaurants(latitude=float(latitude), longitude=float(longitude))
        if query is not None:
            paginator = PageNumberPagination()
            paginator.page_size = 10
            result = paginator.paginate_queryset(query, request)
            context = {
                "Latitude": float(latitude),
                "Longitude": float(longitude)
            }

            list_context = []
            for data in query:
                temp_context = {}
                temp_context["RestaurantID"] = data.RestaurantID
                temp_context["AverageCostForTwo"] = data.AverageCostForTwo
                temp_context["AggregateRating"] = data.AggregateRating
                temp_context["Votes"] = data.Votes
                temp_context["Distance"] = helper.distanceCalc(float(latitude), float(longitude), float(data.Latitude), float(data.Longitude))
                list_context.append(temp_context)

            scaling_data = helper.scaling_data(list_context)
            feature_scaling = helper.featureScaling(scaling_data[0], scaling_data[1], scaling_data[2], scaling_data[3], scaling_data[4], scaling_data[5]) 

            priority_imp = helper.priorityImp(feature_scaling)
            
            max_heap = helper.recommendations(priority_imp)

            query_recommended_restaurants = []
            while(len(max_heap) != 0):
                try:
                    recommended_rest = hp.heappop(max_heap)
                    rest_query = models.Restaurant.objects.filter(RestaurantID=recommended_rest[1]).first()
                    query_recommended_restaurants.append(rest_query)
                except:
                    pass
            
            print(query_recommended_restaurants)
            serializer = serializers.RestaurantSerializer(query_recommended_restaurants, many=True, context=context)
            return SuccessResponse(serializer.data).response()
        return FailureResponse('No Restaurants available in your area', 400).response()


class DonationView(ViewSet):

    def donate(self, request):
        req_token = request.META.get('HTTP_AUTHORIZATION')
        if req_token:
            user_instance = Token.objects.filter(key=req_token).first()
            if user_instance:

                data = request.data
                user = user_instance.user
                name = data["name"]
                latitude = data["latitude"]
                longitude = data["longitude"]
                sufficient_for = data["sufficient_for"]
                date = data["date"]
                time = data["time"]

                models.Donations.objects.create(
                    user = user,
                    name = name,
                    latitude = latitude,
                    longitude = longitude,
                    sufficient_for = sufficient_for,
                    date = date,
                    time = time
                )
                return SuccessResponse("success").response()
            
        return FailureResponse("Token not found! Login Again", 404).response()


    def get_my_donations(self, request):
        req_token = request.META.get('HTTP_AUTHORIZATION')
        if req_token:
            user_instance = Token.objects.filter(key=req_token).first()
            if user_instance: 

                user = user_instance.user
                query = models.Donations.objects.filter(user=user)
                serializer = serializers.DonationSerializer(query, many=True)
                return SuccessResponse(serializer.data).response()
        
        return FailureResponse("Token not found! Login Again", 404).response()


    def get_all_donations(self, request):
        data = request.data
        latitude = data.get("latitude")
        longitude = data.get("longitude")
        if not latitude or not longitude:
            return FailureResponse('Error Fetching Latitude/Longitude', 400).response()
        
        get_nearby_donations = helper.get_nearby_donations(latitude=float(latitude), longitude=float(longitude))

        if get_nearby_donations is None:
            return FailureResponse("No Nearby Donations Available", 404).response()

        # query = models.Donations.objects.all()
        query = get_nearby_donations.order_by("date")
        serializer = serializers.DonationSerializer(query, many=True)
        return SuccessResponse(serializer.data).response()
