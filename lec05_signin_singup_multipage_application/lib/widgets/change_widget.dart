import 'package:flutter/material.dart';

class ChangeWidget extends StatelessWidget {
  const ChangeWidget({super.key, required this.title, required this.onTap});
  final String title;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title, style: TextStyle(color: Colors.orange)),
    );
  }
}
