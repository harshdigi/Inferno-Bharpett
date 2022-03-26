import 'package:bharpett/models/RestaurantModel.dart';
import 'package:bharpett/services/RestaurantService.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/DetailsWidget.dart';
import '../widgets/RestaurantCard.dart';

class VolunteerDashboard extends StatefulWidget {
  const VolunteerDashboard({Key? key}) : super(key: key);

  @override
  State<VolunteerDashboard> createState() => _VolunteerDashboardState();
}

class _VolunteerDashboardState extends State<VolunteerDashboard> {
  String location = 'Null, Press Button';
  List<dynamic> responseData = [];
  bool _isLoading = false;
  double lat = 0.0;
  double long = 0.0;

  getData() async {
    _isLoading = true;
    responseData = await RestaurantService().getData(lat, long);
    setState(() {
      _isLoading = false;
    });
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() async {
    Position position = await _getGeoLocationPosition();
    lat = position.latitude;
    long = position.longitude;
  }

  @override
  void initState() {
    getLatLong();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Hello Volunteer Name",
                    style: TextStyle(color: Colors.black, fontSize: 26),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      Position position = await _getGeoLocationPosition();

                      setState(() {
                        print(
                            'Lat: ${position.latitude}, Long: ${position.longitude}');
                        location =
                            'Lat: ${position.latitude} , Long: ${position.longitude}';
                      });
                    },
                    child: Text("Get"),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              DetailsWidget(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Current Available Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: responseData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RestaurantCard(
                        address: responseData[index]["Address"],
                        aggRating: responseData[index]["AggregateRating"],
                        averageCost: responseData[index]["AverageCostForTwo"],
                        latitude: responseData[index]["Latitude"],
                        longitude: responseData[index]["Longitude"],
                        restaurantName: responseData[index]["RestaurantName"],
                        votes: responseData[index]["Votes"].toString(),
                        distance: responseData[index]["Distance"],
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
