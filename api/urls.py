from django.urls import path, include
from . import views

test = views.TestView.as_view({
    'get': 'test'
})

get_all_restaurants = views.RestaurantView.as_view({
    'get': 'get_all_restaurants'
})

get_single_restaurant = views.RestaurantView.as_view({
    'get': 'get_single_restaurant'
})

donate = views.DonationView.as_view({
    'post': 'donate'
})

my_donations = views.DonationView.as_view({
    'post': 'get_my_donations'
})

urlpatterns = [
    path('test/', test),

    path('get_all_restaurants/', get_all_restaurants),
    path('get_single_restaurant/<int:id>/', get_single_restaurant),

    path('get_my_donations/', my_donations),
]