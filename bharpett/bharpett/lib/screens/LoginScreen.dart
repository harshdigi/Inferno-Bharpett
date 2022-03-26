import 'dart:async';
import 'package:bharpett/screens/DonatorDashboard.dart';
import 'package:bharpett/screens/RoleSelectionScreen.dart';
import 'package:bharpett/screens/VolunteerDashboard.dart';
import 'package:bharpett/services/AuthService.dart';
import 'package:bharpett/widgets/AnimatedText.dart';
import 'package:bharpett/widgets/BottomText.dart';
import 'package:bharpett/widgets/CustomButton.dart';
import 'package:bharpett/widgets/FormFieldWidget.dart';
import 'package:bharpett/widgets/RedDivider.dart';
import 'package:bharpett/widgets/RedLoader.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _opacity = 0;
  String email = '';
  String password = '';
  bool _isLoading = false;
  bool _obscureText = true;
  String token = '';
  String role = '';
  Map map = {};

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    Timer(
        Duration(seconds: 1),
        () => {
              setState(() => {_opacity = 1})
            });
  }

  getTokenAndRole() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var Token = sharedPreferences.getString('token');
    var Role = sharedPreferences.getString('role');
    print(Token);
    print(Role);
  }

  loginUser() {
    setState(() {
      _isLoading = true;
    });
    AuthService().loginUser(email, password).then((value) {
      map = value['message'];
      token = map['token'];
      role = map['role'];
      // getTokenAndRole();
      if (token != '') {
        _isLoading = false;
        print(role);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => role == "DONATOR"
                    ? DonatorDashboard()
                    : VolunteerDashboard()));
        // Navigator.pushReplacement(
        //     context,
        //     PageTransition(
        //         child: VolunteerDashboard(), type: PageTransitionType.fade));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? RedLoader()
        : SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                            height: 150,
                            width: 120,
                            child: Hero(
                                tag: 'logo',
                                child: Image.asset('assets/logo/logo.png'))),
                        Center(
                          child: AnimatedText(
                            opacity: _opacity,
                            text: "Hello!\nWelcome back to BHARPETT",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 6.0)
                            ],
                            color: Color(0xffEEEEEE),
                            borderRadius: BorderRadius.circular(20)),
                        height: 300,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FormFieldWidget(
                                labelText: 'Email',
                                onChanged: (value) {
                                  email = value;
                                },
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              FormFieldWidget(
                                labelText: 'Password',
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: _obscureText,
                                keyboardType: TextInputType.visiblePassword,
                                suffixIcon: IconButton(
                                  focusColor: kPrimaryColor,
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  icon: Icon(_obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              CustomButton(
                                text: 'LOGIN',
                                onPressed: () {
                                  loginUser();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    RedDivider(),
                    SizedBox(
                      height: 20,
                    ),
                    BottomText(
                      text: "New User? ",
                      tapText: "Register Here",
                      screen: RoleSelectionScreen(),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
