import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  const GameOverScreen({required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, -0.3),
      child: isGameOver
          ? Container(
              child: const Text(
                "G A M E  O V E R",
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            )
          : Container(),
    );
  }
}
