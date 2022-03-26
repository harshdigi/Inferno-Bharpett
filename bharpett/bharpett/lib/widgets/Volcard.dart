import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class VolCard extends StatefulWidget {
  final Color color;
  final String name;
  final String latitude;
  final String longitude;
  final String date;
  const VolCard(
      {Key? key,
      required this.color,
      required this.name,
      required this.date,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  @override
  State<VolCard> createState() => _VolCardState();
}

class _VolCardState extends State<VolCard> {
  Future<void> openMaps() async {
    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=23.37498889,85.33548611";
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw "could not open map";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 100,
                width: 120,
                child: Center(
                    child: Column(
                  children: [
                    IconButton(
                        onPressed: () {
                          MapsLauncher.launchCoordinates(23.37498889,
                              85.33548611, 'Nearest Donation Center');
                        },
                        icon: Icon(
                          Icons.map,
                          size: 40,
                          color: Colors.white,
                        )),
                    Text(
                      widget.name,
                    ),
                    Text(widget.date),
                  ],
                ))),
            MaterialButton(onPressed: () {
              // _openMap();
            })
          ],
        ),
      ),
    );
  }
}
