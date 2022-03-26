import 'package:bharpett/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class TapButton extends StatefulWidget {
  late String tapText;
  late Widget nextScreen;

  TapButton({Key? key, required this.tapText, required this.nextScreen})
      : super(key: key);

  @override
  State<TapButton> createState() => _TapButtonState();
}

class _TapButtonState extends State<TapButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: widget.nextScreen,
                  type: PageTransitionType.rightToLeft));
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor,
            ),
            height: 40,
            width: MediaQuery.of(context).size.width / 2.7,
            child: Center(
              child: Text(
                widget.tapText,
                style: const TextStyle(
                    letterSpacing: 1,
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900),
              ),
            )));
  }
}
