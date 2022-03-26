class RestuarantModel {
  late String restaurantName;
  late String city;
  late String address;
  late String locality;
  late String longitude;
  late String latitude;
  late String avgCostForTwo;
  late String aggRating;
  late String distance;
  late String votes;

  RestuarantModel(
      {required this.restaurantName,
      required this.city,
      required this.address,
      required this.locality,
      required this.longitude,
      required this.latitude,
      required this.aggRating,
      required this.avgCostForTwo,
      required this.distance,
      required this.votes});
}
