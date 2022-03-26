import 'package:bharpett/constants.dart';
import 'package:flutter/material.dart';

class RedDivider extends StatelessWidget {
  const RedDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 29),
      height: 2,
      width: _width,
      color: kPrimaryColor,
    );
  }
}
