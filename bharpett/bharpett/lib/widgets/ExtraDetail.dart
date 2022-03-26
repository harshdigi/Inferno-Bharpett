import 'package:flutter/material.dart';

class ExtraDetail extends StatefulWidget {
  Color color;
  Icon icon;
  String text;
  String text2;
  ExtraDetail(
      {Key? key,
      required this.color,
      required this.icon,
      required this.text,
      required this.text2})
      : super(key: key);

  @override
  State<ExtraDetail> createState() => _ExtraDetailState();
}

class _ExtraDetailState extends State<ExtraDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              widget.icon,
              Text(
                widget.text2,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          height: 120,
          width: 115,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 6.0)
          ], color: widget.color, borderRadius: BorderRadius.circular(20)),
        ),
      ],
    );
  }
}
