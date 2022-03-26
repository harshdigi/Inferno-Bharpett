import 'package:flutter/material.dart';

class PreviousDonationHistory extends StatefulWidget {
  const PreviousDonationHistory({Key? key}) : super(key: key);

  @override
  State<PreviousDonationHistory> createState() =>
      _PreviousDonationHistoryState();
}

class _PreviousDonationHistoryState extends State<PreviousDonationHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink[50],
      height: 500,
      width: double.infinity,
    );
  }
}
