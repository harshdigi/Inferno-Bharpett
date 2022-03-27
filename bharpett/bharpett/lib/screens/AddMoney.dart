import 'package:bharpett/widgets/CustomButton.dart';
import 'package:bharpett/widgets/FormFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key? key}) : super(key: key);

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  double latitude = 23.37498889;
  double longitude = 85.33548611;
  String amount = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Add Money to account",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldWidget(
              labelText: 'Donation Amount',
              onChanged: (value) {
                amount = value;
              },
              obscureText: false,
              keyboardType: TextInputType.number,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.attach_money)),
            ),
            FormFieldWidget(
              labelText: 'Transaction ID',
              onChanged: (value) {},
              obscureText: false,
              keyboardType: TextInputType.text,
              suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.insert_drive_file_rounded)),
            ),
            FormFieldWidget(
              labelText: 'Account Name',
              onChanged: (value) {},
              obscureText: false,
              keyboardType: TextInputType.text,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.person)),
            ),
            CustomButton(
              text: 'ADD Money',
              onPressed: () {
                updateAmount() async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString('amount', amount);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
