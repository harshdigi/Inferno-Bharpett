import 'package:bharpett/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoleSelector extends StatelessWidget {
  String role;
  Color color;
  String imagePath;

  RoleSelector(
      {Key? key,
      required this.role,
      required this.color,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2),
                  ),
                  Text(
                    "Tap Here",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
            Image.asset(imagePath),
          ],
        ),
      ),
    );
  }
}
