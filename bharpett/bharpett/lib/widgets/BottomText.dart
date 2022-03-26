import 'package:bharpett/widgets/TapButton.dart';
import 'package:flutter/material.dart';

class BottomText extends StatelessWidget {
  final String text;
  final String tapText;
  final Widget screen;

  BottomText(
      {Key? key,
      required this.text,
      required this.tapText,
      required this.screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          width: 5,
        ),
        TapButton(tapText: tapText, nextScreen: screen)
      ],
    );
  }
}
