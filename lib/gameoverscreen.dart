import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;
  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.deepPurple.shade600,
      letterSpacing: 0,
      fontSize: 25,
    ),
  );
  const GameOverScreen({required this.isGameOver, required this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
          children: [
            Container(
              alignment: const Alignment(0, -0.3 ),
                child: Text(
                  "GAME OVER",
                  style: gameFont,
                ),
              ),
            Container(
              alignment: const Alignment(0, 0),
              child: GestureDetector(
                onTap:  function,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    
                    child: const Text(
                      "PLAY AGAIN",
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
        : Container();
  }
}
