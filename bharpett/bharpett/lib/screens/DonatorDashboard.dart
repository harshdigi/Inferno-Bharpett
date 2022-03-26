import 'package:bharpett/screens/AddForm.dart';
import 'package:bharpett/screens/AddMoney.dart';
import 'package:bharpett/widgets/CustomButton.dart';
import 'package:bharpett/widgets/DetailsWidget.dart';
import 'package:bharpett/widgets/PreviousDonationHistory.dart';
import 'package:flutter/material.dart';

class DonatorDashboard extends StatefulWidget {
  const DonatorDashboard({Key? key}) : super(key: key);

  @override
  State<DonatorDashboard> createState() => _DonatorDashboardState();
}

class _DonatorDashboardState extends State<DonatorDashboard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 60, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Donator Ram!",
              style: TextStyle(color: Colors.black, fontSize: 26),
            ),
            SizedBox(
              height: 30,
            ),
            DetailsWidget(),
            SizedBox(
              height: 30,
            ),
            PreviousDonationHistory(),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  child: Text(
                    "ADD DONATION",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddForm()));
                  },
                  color: Colors.red,
                  height: 40,
                  minWidth: width / 2.3,
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  child: Text(
                    "ADD MONEY",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddMoney()));
                  },
                  color: Colors.red,
                  height: 40,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
