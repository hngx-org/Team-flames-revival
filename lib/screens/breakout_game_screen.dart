import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/screens/game_over_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

final game = BreakoutGame();

class BreakoutGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, BreakoutGame game) =>
            GameOverMenu(game: game),
      },
    );
  }
}
