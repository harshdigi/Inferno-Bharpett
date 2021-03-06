from logging import exception
from django.shortcuts import render

# REST FRAMEWORK
from rest_framework.authtoken.models import Token
from rest_framework import permissions
from rest_framework.authentication import TokenAuthentication
from rest_framework.viewsets import ViewSet
from extensions.handlers import SuccessResponse, FailureResponse

from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import auth
from django.http import JsonResponse

from . import models, serializers

# Create your views here.

class UserAuthView(ViewSet):

    def register(self, request):

        data = request.data
        fullname = data["fullname"].split()
        fname = fullname[0]

        try:
            lname = fullname[1]
        except:
            lname = ""

        username = data["email"]
        email = data["email"]
        phone = data["phone"]
        password = data["password"]
        role = data["role"]

        existing_user = models.UserProfile.objects.filter(username=username).first()
        if existing_user:
            return FailureResponse('User with that email already exists', 400).response()

        user = models.UserProfile.objects.create(
            username=email, 
            first_name = fname,
            last_name = lname,
            email = email,
            phone=phone,
            password = make_password(password),
            role = role
        )

        token = Token.objects.create(user=user)
        context = {
            "token": token,
            "role": role 
        }
        return SuccessResponse("success").response()

    
    def login(self, request):

        data = request.data
        username = data["email"]
        password = data["password"]

        user = auth.authenticate(username=username, password=password)
        if user is not None:
            token = Token.objects.filter(user=user).first().key
            context = {
                "token": token,
                "role": user.role
            }
            return SuccessResponse(context, 200).response()
        return FailureResponse("User not found", 404).response()


class UserDataView(ViewSet):

    def get_data(self, request):
        req_token = request.META.get('HTTP_AUTHORIZATION')
        if req_token:
            user_instance = Token.objects.filter(key=req_token).first()

            if user_instance:
                user = user_instance.user
                serializer = serializers.UserSerializer(user, many=False)
                return SuccessResponse(serializer.data, 200).response()
            else:
                return FailureResponse("Token not found! Login Again", 404).response()
        else:
            return FailureResponse("Token not found! Login Again", 404).response()
        