import 'package:flutter/material.dart';

class ExtraDetail extends StatefulWidget {
  Color color;
  ExtraDetail({Key? key, required this.color}) : super(key: key);

  @override
  State<ExtraDetail> createState() => _ExtraDetailState();
}

class _ExtraDetailState extends State<ExtraDetail> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
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
