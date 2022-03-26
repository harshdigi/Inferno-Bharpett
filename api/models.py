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

    def __str__(self):
        return self.RestaurantName