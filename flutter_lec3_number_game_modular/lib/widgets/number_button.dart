import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  final int number;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onPressed;
  const NumberButton({
    super.key,
    required this.number,
    required this.isSelected,
    required this.isCorrect,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).colorScheme.primary;

    if (isSelected) {
      backgroundColor = isCorrect ? Colors.green : Colors.red;
    }

    return SizedBox(
      width: 120.0,
      height: 120.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          elevation: isSelected ? 8.0 : 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.all(0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$number',
              style: const TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 4.0),
              Icon(isCorrect ? Icons.check : Icons.close, size: 20.0),
            ],
          ],
        ),
      ),
    );
  }
}
