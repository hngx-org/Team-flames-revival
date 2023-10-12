import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final brickWidth;
  final brickHeight;
  final brickX;
  final brickY;
  final brickBroken;
  const MyBrick({
    required this.brickWidth,
    required this.brickHeight,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(brickX, brickY),
      child: brickBroken
          ? Container()
          : ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: MediaQuery.of(context).size.height * brickHeight / 2,
                width: MediaQuery.of(context).size.width * brickWidth / 2,
                color: Colors.deepPurple,
              ),
            ),
    );
  }
}
