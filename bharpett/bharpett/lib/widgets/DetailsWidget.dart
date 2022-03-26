import 'package:bharpett/widgets/ExtraDetail.dart';
import 'package:flutter/material.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({Key? key}) : super(key: key);

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExtraDetail(
          color: Color(0xffFD5D5D),
        ),
        SizedBox(
          width: 5,
        ),
        ExtraDetail(
          color: Color(0xffFFF7BC),
        ),
        SizedBox(
          width: 5,
        ),
        ExtraDetail(
          color: Color(0xffFF8080),
        ),
      ],
    );
  }
}
