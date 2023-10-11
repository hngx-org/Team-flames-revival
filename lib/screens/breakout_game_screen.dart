import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
class BreakoutGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = BreakoutGame();
    return Scaffold(
      body: GameWidget(game: game),
    );
  }
}
