from sqlite3 import paramstyle
from django.shortcuts import render

# REST FRAMEWORK
from rest_framework.response import Response
from rest_framework.viewsets import ViewSet

from . import serializers, models

import firebase_admin
from extensions.handlers import SuccessResponse, FailureResponse
from firebase_admin import credentials, auth

# Create your views here.

if not firebase_admin._apps:
    cred = credentials.Certificate('firebase.json')
    default_app = firebase_admin.initialize_app(cred)

class TestView(ViewSet):

    def test(self, request):
        # params = request.GET
        # uid = params["uid"]
        # auth.get_user(uid)
        return SuccessResponse('Working').response()


class MealView(ViewSet):

    def get_all_meals(self, request):
        return SuccessResponse('working').response()


    def get_single_meal(self, request):
        pass
        return SuccessResponse('Working').response()