import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  final double ballX;
  final double ballY;
  final double ballRadius; // Add this

  MyBall({
    required this.ballX,
    required this.ballY,
    required this.ballRadius, // Add this
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(ballX, ballY),
      child: Container(
        height: MediaQuery.of(context).size.width *
            ballRadius *
            2, // Use the ballRadius to set the diameter
        width: MediaQuery.of(context).size.width *
            ballRadius *
            2, // Use the ballRadius to set the diameter
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
