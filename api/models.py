from secrets import choice
from django.db import models

# Create your models here.

class Restaurant(models.Model):

    RestaurantID = models.IntegerField(blank=False, null=False)
    RestaurantName = models.CharField(max_length=555)
    CountryCode = models.CharField(max_length=255)
    City = models.CharField(max_length=555)
    Address = models.TextField()
    Locality = models.TextField()
    LocalityVerbose = models.TextField()
    Longitude = models.CharField(max_length=555)
    Latitude = models.CharField(max_length=555)
    Cuisines = models.TextField()
    Address = models.TextField()
    AverageCostForTwo = models.CharField(max_length=555)
    Currency = models.CharField(max_length=555)
    PriceRange = models.IntegerField()
    AggregateRating = models.CharField(max_length=555)
    Votes = models.IntegerField()    


STATUS = (
    ("PENDING", "PENDING"),
    ("ACTIVE", "ACTIVE"),
    ("COMPLETED", "COMPLETED"),
    ("EXPIRED", "EXPIRED"),
)
class Donations(models.Model):
    name = models.CharField(max_length= 500, )
    latitude = models.CharField(max_length=500 )
    longitude = models.CharField(max_length= 500)
    date = models.DateField( auto_now=False, auto_now_add=False)
    time = models.TimeField(auto_now=False, auto_now_add=False)
    sufficient_for = models.IntegerField()
    status = models.CharField(max_length=155, choices=STATUS, default="PENDING")

    def __str__(self):
        return self.name