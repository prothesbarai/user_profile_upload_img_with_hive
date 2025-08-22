import 'package:flutter/material.dart';
class SunBg extends StatelessWidget {
  const SunBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffff7043),
                Color(0xff283593),
                Color(0xff0d1b2a),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, -0.1), // sun center
              radius: 0.6,
              colors: [
                Color(0xffffeb3b),
                Color(0x00ffd54f),
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        Align(
          alignment: const Alignment(0, -0.1), // sun ava center
          child: Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffffd54f),
              boxShadow: [
                BoxShadow(
                  color: Color(0xfffff176),
                  blurRadius: 80,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
