import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final double opacity;
  final String text;

  AnimatedText({Key? key, required this.opacity, required this.text})
      : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.opacity,
      duration: Duration(seconds: 2),
      child: Text(widget.text,
          style: TextStyle(
              fontSize: 17.8,
              color: Colors.black,
              fontWeight: FontWeight.w600)),
    );
  }
}
