import 'package:flutter/material.dart';

class PlayPrompt extends StatelessWidget {
  const PlayPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Tap the larger number!',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}
