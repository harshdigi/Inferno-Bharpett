from django.shortcuts import render

# REST FRAMEWORK
from rest_framework.authtoken.models import Token
from rest_framework import permissions
from rest_framework.authentication import TokenAuthentication
from rest_framework.viewsets import ViewSet
from extensions.handlers import SuccessResponse, FailureResponse

from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import auth

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

        if(models.UserProfile.objects.filter(username=username).exists()):
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
        Token.objects.create(user=user)

        return SuccessResponse("User created successfully", 200).response()

    
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

    # permission_classes = [permissions.IsAuthenticated]

    def get_data(self, request):
        user = models.UserProfile.objects.filter(username=request.user).first()
        if user:
            serializer = serializers.UserSerializer(user, many=False)
            return SuccessResponse(serializer.data, 200).response()
        return FailureResponse("User not found", 404).response()
        