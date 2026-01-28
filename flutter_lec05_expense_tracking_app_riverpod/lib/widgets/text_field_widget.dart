import 'package:flutter/material.dart';
import 'package:flutter_lec05_expense_tracking_app_riverpod/constants.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Constants.appColor, fontSize: 14.0),
      decoration: InputDecoration(
        hintText: title,
        labelStyle: TextStyle(color: Constants.appColor),
        focusColor: Constants.appColor,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Constants.appColor),
        ),
        labelText: title,
      ),
    );
  }
}
