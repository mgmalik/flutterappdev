import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lec5_signin_signup_app/widgets/clipper_widget.dart';

class WaveWidget extends StatefulWidget {
  const WaveWidget({
    super.key,
    required this.size,
    required this.yOffset,
    required this.color,
  });

  final Size size;
  final double yOffset;
  final Color color;

  @override
  State<WaveWidget> createState() => _WaveWidgetState();
}

class _WaveWidgetState extends State<WaveWidget> with TickerProviderStateMixin {
  late AnimationController animationController;
  List<Offset> wavePoints = [];

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..addListener(() {
            wavePoints.clear();

            final double waveSpeed = animationController.value * 1080;
            final double fullSphere = animationController.value * pi * 2;
            final double normalizer = cos(fullSphere);
            final double waveWidth = pi / 270;
            final double waveHeight = 25.0;

            for (int i = 0; i <= widget.size.width.toInt(); ++i) {
              double calc = sin((waveSpeed - i) * waveWidth);
              wavePoints.add(
                Offset(
                  i.toDouble(), //X
                  calc * waveHeight * normalizer + widget.yOffset, //Y
                ),
              );
            }
          });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, _) {
        return ClipPath(
          clipper: ClipperWidget(waveList: wavePoints),
          child: Container(
            width: widget.size.width,
            height: widget.size.height,
            color: widget.color,
          ),
        );
      },
    );
  }
}
