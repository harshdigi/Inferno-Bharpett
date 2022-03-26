import 'package:bharpett/models/RestaurantModel.dart';
import 'package:bharpett/services/RestaurantService.dart';
import 'package:bharpett/widgets/Volcard.dart';
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
  List<dynamic> responseData = [
    {
      "id": 1,
      "name": "Holi Donation",
      "latitude": "23.37498889",
      "longitude": "85.33548611",
      "date": "2022-03-26",
      "time": "19:27:55",
      "sufficient_for": "10",
      "status": "EXPIRED",
      "user": 17
    },
    {
      "id": 2,
      "name": "MIT ADT Donation",
      "latitude": "23.37498889",
      "longitude": "85.33548611",
      "date": "2022-03-26",
      "time": "19:28:33",
      "sufficient_for": "12",
      "status": "EXPIRED",
      "user": 17
    },
    {
      "id": 3,
      "name": "Pune Drive",
      "latitude": "23.37498889",
      "longitude": "85.33548611",
      "date": "2022-03-26",
      "time": "19:28:53",
      "sufficient_for": "16",
      "status": "EXPIRED",
      "user": 17
    },
    {
      "id": 4,
      "name": "Iskon Food",
      "latitude": "23.37498889",
      "longitude": "85.33548611",
      "date": "2022-03-26",
      "time": "19:29:15",
      "sufficient_for": "18",
      "status": "EXPIRED",
      "user": 17
    },
    {
      "id": 5,
      "name": "Everday Hunger",
      "latitude": "23.37498889",
      "longitude": "85.33548611",
      "date": "2022-03-26",
      "time": "19:55:33",
      "sufficient_for": "12",
      "status": "EXPIRED",
      "user": 17
    },
    {
      "id": 6,
      "name": "PiggyBank",
      "latitude": "23.37498889",
      "longitude": "85.33548611",
      "date": "2022-03-26",
      "time": "19:56:04",
      "sufficient_for": "18",
      "status": "EXPIRED",
      "user": 17
    },
    {
      "id": 7,
      "name": "Peace Drive",
      "latitude": "23.37498889",
      "longitude": "85.33548611",
      "date": "2022-03-26",
      "time": "19:56:39",
      "sufficient_for": "16",
      "status": "EXPIRED",
      "user": 17
    }
  ];
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
                    "Hello Volunteer Vinay",
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
                    child: Row(
                      children: [Text("Get"), Icon(Icons.location_on)],
                    ),
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
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    VolCard(
                      name: "Holi Donation",
                      date: "2022-03-26",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFD5D5D),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    VolCard(
                      name: "MIT ADT Donation",
                      date: "2022-03-26",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFFF7BC),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    VolCard(
                      name: "Pune Drive",
                      date: "2022-03-21",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFF8080),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    VolCard(
                      name: "Everyday Hunger",
                      date: "2022-03-13",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFD5D5D),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ])),
              SizedBox(
                height: 10,
              ),
              Text(
                "Available Restaurants Near You",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: 200,
                  width: double.infinity,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    VolCard(
                      name: "Holi Donation",
                      date: "2022-03-26",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFD5D5D),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    VolCard(
                      name: "MIT ADT Donation",
                      date: "2022-03-26",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFFF7BC),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    VolCard(
                      name: "Pune Drive",
                      date: "2022-03-21",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFF8080),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    VolCard(
                      name: "Everyday Hunger",
                      date: "2022-03-13",
                      latitude: "23.37498889",
                      longitude: "85.33548611",
                      color: Color(0xffFD5D5D),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ])),
              SizedBox(
                height: 10,
              ),
              Text(
                "Current Available Tasks",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
