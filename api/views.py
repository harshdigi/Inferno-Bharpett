from django.shortcuts import render
from django.views import View

# REST FRAMEWORK
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet
from rest_framework.pagination import PageNumberPagination

from . import serializers, models
from utils import helper
import pyrebase

from extensions.handlers import SuccessResponse, FailureResponse
# import firebase_admin
# from firebase_admin import credentials, auth, firestore

# Create your views here.

# if not firebase_admin._apps:
#     cred = credentials.Certificate('bharpett-2fd11-firebase-adminsdk-9soyx-51e6e0192a.json')
#     default_app = firebase_admin.initialize_app(cred, {
#         'databaseURL': 'https://bharpett-2fd11-default-rtdb.firebaseio.com/'
#     })
#     db = firestore.client()


class TestView(ViewSet):

    def test(self, request):
        # params = request.GET
        # uid = params["uid"]
        # data = db.collection("current_donation/hardik/")
        # try:
        #     user_instance = auth.get_user('zhTj7XicOlSyNUh7dE0qFpr6gHf2')
        #     return SuccessResponse('Working').response()
        # except:
        #     return FailureResponse('No user found', 404).response()

        return SuccessResponse('Working').response()
        

class RestaurantView(ViewSet):

    def get_all_restaurants(self, request):
        # query = models.Restaurant.objects.all().order_by('id')
        query = helper.get_nearby_restaurants(latitude=23.37498889 , longitude=85.33548611)
        if query:
            paginator = PageNumberPagination()
            paginator.page_size = 10
            result = paginator.paginate_queryset(query, request)
            context = {
                "Latitude": 23.37498889,
                "Longitude": 85.33548611
            }
            serializer = serializers.RestaurantSerializer(result, many=True, context=context)
            return paginator.get_paginated_response(serializer.data)
        return FailureResponse('Internal Server Error', 500).response()


    def get_single_restaurant(self, request, id):
        query = models.Restaurant.objects.filter(id=id).first()
        if query:
            serializer = serializers.RestaurantSerializer(query, many=False)
            return SuccessResponse(serializer.data).response()
        return FailureResponse('Restaurant Not Found', 404).response()