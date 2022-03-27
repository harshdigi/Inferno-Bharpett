import 'package:bharpett/widgets/ExtraDetail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsWidget extends StatefulWidget {
  const DetailsWidget({Key? key}) : super(key: key);

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  String? amount = '';

  getAmount() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    amount = sharedPreferences.getString('amount');
  }

  @override
  void initState() {
    super.initState();
    getAmount();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExtraDetail(
          text2: "20",
          text: "Total\nDonations",
          icon: Icon(
            Icons.card_giftcard,
            size: 40,
          ),
          color: Color(0xffFD5D5D),
        ),
        SizedBox(
          width: 5,
        ),
        ExtraDetail(
          text2: "1500",
          text: "Wallet\nAmount",
          icon: Icon(
            Icons.attach_money,
            size: 40,
          ),
          color: Color(0xffFFF7BC),
        ),
        SizedBox(
          width: 5,
        ),
        ExtraDetail(
          text2: "5",
          text: "Current\nDonations",
          icon: Icon(
            Icons.task,
            size: 40,
          ),
          color: Color(0xffFF8080),
        ),
      ],
    );
  }
}
