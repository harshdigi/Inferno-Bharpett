from logging import exception
from django.shortcuts import render
from django.views import View

# REST FRAMEWORK
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from rest_framework.pagination import PageNumberPagination

from . import serializers, models
from utils import helper

from extensions.handlers import SuccessResponse, FailureResponse


class TestView(ViewSet):

    def test(self, request):
        return SuccessResponse('Working').response()
        

class RestaurantView(ViewSet):

    def get_all_restaurants(self, request):
        query = helper.get_nearby_restaurants(latitude=23.37498889 , longitude=85.33548611)
        if query is not None:
            paginator = PageNumberPagination()
            paginator.page_size = 10
            result = paginator.paginate_queryset(query, request)
            context = {
                "Latitude": 23.37498889,
                "Longitude": 85.33548611
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