import 'package:bharpett/constants.dart';
import 'package:bharpett/screens/AccountSuccess.dart';
import 'package:bharpett/screens/DonatorDashboard.dart';
import 'package:bharpett/screens/VolunteerDashboard.dart';
import 'package:bharpett/services/AuthService.dart';
import 'package:bharpett/widgets/CustomButton.dart';
import 'package:bharpett/widgets/FormFieldWidget.dart';
import 'package:bharpett/widgets/RedDivider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import '../widgets/BottomText.dart';
import '../widgets/RedLoader.dart';
import 'LoginScreen.dart';

class RegisterScreen extends StatefulWidget {
  String role;
  RegisterScreen({Key? key, required this.role}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  bool _obscureText = true;
  String confirm_password = '';
  String token = '';
  bool _isLoading = false;
  String message = '';

  @override
  void initState() {
    super.initState();
    print(widget.role);
    _isLoading = false;
  }

  createUser() {
    setState(() {
      _isLoading = true;
    });
    AuthService()
        .createUser(name, email, password, phone, widget.role)
        .then((value) {
      message = value;
      print(message);
      if (message != '' && message == "success") {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: AccountSuccess(), type: PageTransitionType.fade));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.role == "DONATOR"
                  ? "Welcome Donator,"
                  : "Welcome Volunteer,",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7),
            ),
            Text(
              widget.role == "DONATOR"
                  ? "Help us Reduce Hunger!"
                  : "Become a Superhero!",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: widget.role == "DONATOR"
                    ? LottieBuilder.asset("assets/animations/donation1.json")
                    : LottieBuilder.asset(
                        "assets/animations/volunteering.json")),
            SizedBox(
              height: 10,
            ),
            FormFieldWidget(
              labelText: 'Name',
              onChanged: (value) {
                name = value;
              },
              obscureText: false,
              keyboardType: TextInputType.name,
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldWidget(
              labelText: 'Email',
              onChanged: (value) {
                email = value;
              },
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldWidget(
              labelText: 'Phone',
              onChanged: (value) {
                phone = value;
              },
              obscureText: false,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldWidget(
              labelText: 'Password',
              onChanged: (value) {
                password = value;
              },
              obscureText: _obscureText,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                focusColor: kPrimaryColor,
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FormFieldWidget(
              labelText: 'Confirm Password',
              onChanged: (value) {
                confirm_password = value;
              },
              obscureText: _obscureText,
              keyboardType: TextInputType.visiblePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              text: "REGISTER",
              onPressed: () {
                if (password == confirm_password) {
                  createUser();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')));
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            RedDivider(),
            SizedBox(
              height: 10,
            ),
            BottomText(
              text: "Already a User? ",
              tapText: "Login Here",
              screen: LoginScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
