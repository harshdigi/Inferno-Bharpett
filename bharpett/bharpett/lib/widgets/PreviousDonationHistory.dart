import 'package:flutter/material.dart';

class PreviousDonationHistory extends StatefulWidget {
  const PreviousDonationHistory({Key? key}) : super(key: key);

  @override
  State<PreviousDonationHistory> createState() =>
      _PreviousDonationHistoryState();
}

class _PreviousDonationHistoryState extends State<PreviousDonationHistory> {
  final List<dynamic> data = [
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
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      height: 450,
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink[50],
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0),
                            blurRadius: 6.0)
                      ],
                    ),
                    child: ListTile(
                        leading: Image.asset('assets/logo/logo.png'),
                        title: Text(data[index]['name']),
                        subtitle: Text('Status of this donation drive is: ' +
                            data[index]['status']),
                        isThreeLine: true),
                  ));
                }),
            // child: Text(
            //   "PREVIOUS DONATION HISTORY",
            //   style: TextStyle(
            //       fontSize: 22, letterSpacing: 1, fontWeight: FontWeight.bold),
            // ),
          ),
        ],
      ),
    );
  }
}
