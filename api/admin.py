from django.contrib import admin
from . import models
from import_export.admin import ImportExportModelAdmin

# Register your models here.

class MealAdmin(ImportExportModelAdmin, admin.ModelAdmin):
    pass

admin.site.register(models.Meal, MealAdmin)  