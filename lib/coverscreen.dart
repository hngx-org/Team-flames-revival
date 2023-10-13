import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;

  const CoverScreen({required this.tapToPlay, required this.hasGameStarted, required this.isGameOver});
  final bool tapToPlay;


static var gameFont = GoogleFonts.pressStart2p(
  textStyle: TextStyle(
    color: Colors.deepPurple[600], letterSpacing: 0, fontSize: 27
  )
);


  @override
  Widget build(BuildContext context) {
    return isGameOver
        ?  Container(
                alignment: Alignment(0, -0.5),
                child: Text(
                 isGameOver? '': "ATARI BREAKOUT",
                  style: gameFont.copyWith(color: Colors.deepPurple[100])
                ),
              )
        : Stack(
          children: [
            Container(
                alignment: Alignment(0, -0.5),
                child: Text(
                  "ATARI BREAKOUT",
                  style: gameFont
                ),
              ),

              // Container(
              //   alignment: Alignment(0, -0.1),
              //   child: Text(
              //     " play",
              //     style: TextStyle(
              //       color: Colors.deepPurple[400],
              //       )
              //   ),
              // )
          ],
        );
  }
}
