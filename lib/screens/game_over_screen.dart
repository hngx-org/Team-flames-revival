import 'package:breakout_revival/components/menu_button.dart';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GameOverMenu extends StatelessWidget {
  static const String ID = 'GameOverMenu';
  BreakoutGame game;
  GameOverMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menu_img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            build3DButton(
              'Play Again',
              onPressed: () {
                game.overlays.remove(GameOverMenu.ID);
                game.resetGame();
                game.resumeEngine();
              },
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}
