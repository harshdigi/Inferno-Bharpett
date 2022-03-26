from email.policy import default
from random import choices
from secrets import choice
from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

USER_ROLES = (
    ("DONATOR", "DONATOR"),
    ("VOLUNTEER", "VOLUNTEER")
)
class UserProfile(AbstractUser):

    role = models.CharField(max_length=155, choices=USER_ROLES, default="VOLUNTEER")
    phone = models.CharField(max_length=155)
    
    def __str__(self):
        return self.username


class Wallet(models.Model):

    user = models.ForeignKey(
        to=UserProfile, on_delete=models.CASCADE
    )
    balance = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)

    def __str__(self):
        return self.user.username