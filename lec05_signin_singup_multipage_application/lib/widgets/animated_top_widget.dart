import 'package:flutter/material.dart';
import 'package:lec05_signin_singup_multipage_application/widgets/wave_widget.dart';

class AnimatedTopWidget extends StatelessWidget {
  const AnimatedTopWidget({
    super.key,
    required this.title,
    required this.size,
    required this.keyboardOpen,
  });

  final String title;
  final Size size;
  final bool keyboardOpen;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(height: size.height - 200, color: Colors.indigo),
        AnimatedPositioned(
          duration: Duration(seconds: 5),
          curve: Curves.easeOutQuad,
          top: keyboardOpen ? -size.height / 3.7 : 0.0,
          child: WaveWidget(
            size: size,
            yOffset: size.height / 3.0,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: (keyboardOpen ? 15.0 : 100.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
