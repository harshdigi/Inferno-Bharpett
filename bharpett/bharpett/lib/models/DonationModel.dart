class DonationModel {
  late String name;
  late String latitude;
  late String longitude;
  late String date;
  late String time;
  late String sufficientfor;
  late String status;

  DonationModel(
      {required this.name,
      required this.longitude,
      required this.latitude,
      required this.date,
      required this.time,
      required this.sufficientfor,
      required this.status});
}
