# Generated by Django 4.0.3 on 2022-03-26 12:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0003_wallet'),
    ]

    operations = [
        migrations.AddField(
            model_name='userprofile',
            name='phone',
            field=models.CharField(default=0, max_length=155),
            preserve_default=False,
        ),
    ]