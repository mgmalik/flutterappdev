import 'package:flutter/material.dart';

class GameRules extends StatelessWidget {
  const GameRules({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rules:',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Tap the larger number to earn 5 points. '
          'Wrong choices lose 5 points. Try to build a streak!',
          style: TextStyle(fontSize: 16.0, color: Colors.blueGrey, height: 1.4),
        ),
      ],
    );
  }
}
