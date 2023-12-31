import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/screens/game_over_screen.dart';
import 'package:breakout_revival/screens/pause_screen.dart';
import 'package:breakout_revival/utils/pause_button.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BreakoutGameScreen extends StatelessWidget {
  const BreakoutGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    final game = BreakoutGame();


   
    return GameWidget(
      game: game,
      initialActiveOverlays: [PauseButton.ID],
      overlayBuilderMap: {
        GameOverMenu.ID: (BuildContext context, BreakoutGame game) =>
            GameOverMenu(game: game),
        PauseButton.ID: (BuildContext context, BreakoutGame game) =>
            PauseButton(game: game),
        PauseMenu.ID: (BuildContext context, BreakoutGame game) =>
            PauseMenu(game: game, ),
      },
    );
  }
}
