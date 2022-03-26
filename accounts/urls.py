from django.urls import path
from . import views

register_view = views.UserAuthView.as_view({
    'post': 'register'
})

login_view = views.UserAuthView.as_view({
    'post': 'login'
})

user_data = views.UserDataView.as_view({
    'get': 'get_data'
})

urlpatterns = [
    path('register/', register_view),
    path('login/', login_view),
    path('user-data/', user_data),
]