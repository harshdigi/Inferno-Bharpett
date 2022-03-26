import 'dart:async';
import 'package:bharpett/screens/RoleSelectionScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const RoleSelectionScreen(),
              type: PageTransitionType.fade));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                    height: _height / 3,
                    width: _width / 1.5,
                    child: Hero(
                        tag: 'logo',
                        child: Image.asset('assets/logo/logo.png'))),
                Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: LottieBuilder.asset(
                        "assets/animations/red_loader.json"))
              ],
            ),
          )
        ],
      ),
    );
  }
}
