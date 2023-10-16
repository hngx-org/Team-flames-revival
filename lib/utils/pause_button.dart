import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/screens/pause_screen.dart';
import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  static const String ID = 'PauseButton';
  BreakoutGame game;
  PauseButton({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        child: Icon(
          Icons.pause,
          color: Colors.white,
        ),
        onPressed: () {
          game.pauseEngine();
          game.overlays.add(PauseMenu.ID);
          game.overlays.remove(PauseButton.ID);
        },
      ),
    );
  }
}
