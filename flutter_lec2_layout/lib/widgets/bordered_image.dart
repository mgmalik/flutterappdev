import 'package:flutter/material.dart';

class BorderedImage extends StatelessWidget {
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final double imageSize;

  const BorderedImage({
    super.key,
    this.borderWidth = 2.0,
    this.borderColor = Colors.blueGrey,
    this.borderRadius = 10.0,
    this.imageSize = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: imageSize + (2 * borderWidth),
      height: imageSize + (2 * borderWidth),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Image.asset(
        'assets/images/flutter_bird.png',
        width: imageSize,
        height: imageSize,
      ),
    );
  }
}
