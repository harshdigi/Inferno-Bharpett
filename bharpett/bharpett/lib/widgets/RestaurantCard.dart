import 'package:flutter/material.dart';

class RestaurantCard extends StatefulWidget {
  final String restaurantName;
  final String address;
  final String longitude;
  final String latitude;
  final String averageCost;
  final String aggRating;
  final String votes;
  final String distance;
  RestaurantCard(
      {Key? key,
      required this.restaurantName,
      required this.address,
      required this.aggRating,
      required this.averageCost,
      required this.distance,
      required this.latitude,
      required this.longitude,
      required this.votes})
      : super(key: key);

  @override
  State<RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    return Card();
  }
}
