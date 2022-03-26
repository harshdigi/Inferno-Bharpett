import 'package:bharpett/constants.dart';
import 'package:flutter/material.dart';

class FormFieldWidget extends StatefulWidget {
  final String labelText;
  final void Function(String)? onChanged;
  final bool obscureText;
  final IconButton? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  FormFieldWidget(
      {required this.labelText,
      required this.onChanged,
      required this.obscureText,
      this.suffixIcon,
      this.validator,
      required this.keyboardType});

  @override
  _FormFieldWidgetState createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: widget.suffixIcon,
          labelStyle: TextStyle(color: kPrimaryColor),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kPrimaryColor, width: 2.0),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xffff5757),
            ),
          )),
    );
  }
}
