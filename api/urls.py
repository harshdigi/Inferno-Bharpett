from django.urls import path, include
from . import views

test = views.TestView.as_view({
    'get': 'test'
})

get_all_meals = views.MealView.as_view({
    'get': 'get_all_meals'
})

get_single_meal = views.MealView.as_view({
    'get': 'get_single_meal'
})

urlpatterns = [
    path('test/', test),

    path('get_all_meals/', get_all_meals),
    path('get_single_meal/', get_single_meal),
]