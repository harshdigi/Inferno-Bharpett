from django.shortcuts import render

# REST FRAMEWORK
from rest_framework.authtoken.models import Token
from rest_framework import permissions
from rest_framework.authentication import TokenAuthentication
from rest_framework.viewsets import ViewSet
from extensions.handlers import SuccessResponse, FailureResponse

from . import models

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
        password = data["password"]
        role = data["role"]

        if(models.UserProfile.objects.filter(username=username).exists()):
            return FailureResponse('User with that email already exists', 400).response()

        user = models.UserProfile.objects.create(
            username=email, 
            first_name = fname,
            last_name = lname,
            email = email,
            password = password,
            role = role
        )
        Token.objects.create(user=user)

        return SuccessResponse("User created successfully", 200).response()

    
    def login(self, request):

        data = request.data
        username = data["email"]
        password = data["password"]

        user = models.UserProfile.objects.filter(username=username, password=password).first()

        if user is not None:
            token = Token.objects.filter(user=user).first().key
            return SuccessResponse(token, 200).response()
        return FailureResponse("User not found", 404).response()