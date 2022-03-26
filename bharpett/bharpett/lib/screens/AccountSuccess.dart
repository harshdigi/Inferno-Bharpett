import 'dart:async';

import 'package:bharpett/screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class AccountSuccess extends StatefulWidget {
  const AccountSuccess({Key? key}) : super(key: key);

  @override
  State<AccountSuccess> createState() => _AccountSuccessState();
}

class _AccountSuccessState extends State<AccountSuccess> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const LoginScreen(), type: PageTransitionType.fade));
    });
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 200,
                child: LottieBuilder.asset('assets/animations/success.json')),
            Text(
              "Account Created Successfully",
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
