import 'package:flutter/material.dart';

class PowerUPs extends StatelessWidget {
  final double height;
  final double width;
  double powerUpX;
  double powerUpY;
  // double powerUpRadius;
  // bool active;

  PowerUPs({
    required this.height,
    required this.width,
    required this.powerUpX,
    required this.powerUpY,
  });

  @override
  Widget build(BuildContext context) {
    double actualWidth = MediaQuery.of(context).size.width * (width / 2);
    double actualHeight = MediaQuery.of(context).size.height * (height / 2);
    return Positioned(
      left: MediaQuery.of(context).size.width * (powerUpX + 1) / 2,
      top: MediaQuery.of(context).size.height * (powerUpY + 1) / 2,
      child: Icon(
        Icons.expand,
        color: const Color.fromARGB(255, 107, 22, 16),
        size: actualHeight,
        fill: 0.8,
      ),
    );
  }
}
