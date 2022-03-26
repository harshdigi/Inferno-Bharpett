from django.urls import path
from . import views

register_view = views.UserAuthView.as_view({
    'post': 'register'
})

login_view = views.UserAuthView.as_view({
    'post': 'login'
})

urlpatterns = [
    path('register/', register_view),
    path('login/', login_view),
]