import 'package:flutter/material.dart';
import 'package:flutter_lec5_signin_signup_app/model/state_provider.dart';
import 'package:provider/provider.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.obscureText,
    required this.onChanged,
    required this.color,
    required this.controller,
    required this.isValid,
  });

  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final Color color;
  final TextEditingController controller;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<StateProvider>(context);
    return TextField(
      obscureText: obscureText,
      cursorColor: color,
      onChanged: onChanged,
      controller: controller,
      style: TextStyle(color: color, fontSize: 14.0),
      decoration: InputDecoration(
        hintText: hintText,
        labelStyle: TextStyle(color: color),
        focusColor: color,
        filled: true,
        prefixIcon: Icon(prefixIconData, size: 18.0, color: color),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: isValid ? color : Colors.redAccent),
        ),
        labelText: hintText,
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(suffixIconData, size: 18, color: color),
        ),
      ),
    );
  }
}
