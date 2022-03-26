import 'package:bharpett/widgets/CustomButton.dart';
import 'package:bharpett/widgets/FormFieldWidget.dart';
import 'package:flutter/material.dart';

class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  double latitude = 23.37498889;
  double longitude = 85.33548611;

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
              "Donation Form",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldWidget(
              labelText: 'Donation Name',
              onChanged: (value) {},
              obscureText: false,
              keyboardType: TextInputType.text,
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.abc)),
            ),
            FormFieldWidget(
              labelText: 'Sufficient For People',
              onChanged: (value) {},
              obscureText: false,
              keyboardType: TextInputType.text,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.people)),
            ),
            FormFieldWidget(
              labelText: 'Date',
              onChanged: (value) {},
              obscureText: false,
              keyboardType: TextInputType.datetime,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: Icon(Icons.date_range)),
            ),
            FormFieldWidget(
              labelText: 'Time',
              onChanged: (value) {},
              obscureText: false,
              keyboardType: TextInputType.datetime,
              suffixIcon: IconButton(
                  onPressed: () {}, icon: Icon(Icons.watch_later_outlined)),
            ),
            CustomButton(text: 'ADD'),
          ],
        ),
      ),
    );
  }
}
