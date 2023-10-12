import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "G A M E  O V E R",
        style: TextStyle(
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}
