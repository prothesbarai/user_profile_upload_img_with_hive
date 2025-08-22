import 'package:flutter/material.dart';

class JosnaNight extends StatelessWidget {
  const JosnaNight({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff0d1b2a), Color(0xff1b263b), Color(0xff415a77),],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),


        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.0, -0.1),
              radius: 0.5,
              colors: [Color(0xffffffff), Color(0x00ffffff),],
              stops: [0.0, 1.0],
            ),
          ),
        ),

        Align(
          alignment: const Alignment(0, -0.1),
          child: Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x88ffffff),
                  blurRadius: 80,
                  spreadRadius: 30,
                ),
              ],
            ),
          ),
        ),


        Positioned.fill(
          child: CustomPaint(
            painter: StarPainter(),
          ),
        ),
      ],
    );
  }
}


class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final randomStars = [Offset(50, 100), Offset(150, 200), Offset(300, 80), Offset(250, 400), Offset(100, 300), Offset(350, 250),];
    for (var star in randomStars) {
      canvas.drawCircle(star, 3, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
