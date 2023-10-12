import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  double ballX;
  double ballY;
  MyBall({
    required this.ballX,
    required this.ballY,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: 15,
        width: 15,
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
