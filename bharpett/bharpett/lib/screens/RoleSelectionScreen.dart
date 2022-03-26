import 'dart:ui';

import 'package:bharpett/screens/LoginScreen.dart';
import 'package:bharpett/widgets/BottomText.dart';
import 'package:bharpett/widgets/RedDivider.dart';
import 'package:bharpett/widgets/RoleSelector.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 50),
              height: _height / 5,
              width: _width / 2,
              child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    "assets/logo/logo.png",
                  )),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Let's get Started,\n I am a...",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height: _height / 2.2,
            width: _width / 1.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RoleSelector(
                  role: "Donator",
                  color: Color(0xffFFC85C),
                  imagePath: "assets/images/Volunteer.png",
                ),
                RoleSelector(
                  role: "Volunteer",
                  color: Color(0xffFFCB8E),
                  imagePath: "assets/images/Donator.png",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const RedDivider(),
          const SizedBox(
            height: 20,
          ),
          BottomText(
            text: "Already a User? ",
            tapText: "Login Here",
            screen: LoginScreen(),
          )
        ],
      ),
    );
  }
}
