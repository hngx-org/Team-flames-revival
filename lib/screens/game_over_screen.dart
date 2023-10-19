import 'package:breakout_revival/screens/menu_screen.dart';
import 'package:breakout_revival/screens/pause_screen.dart';
import 'package:breakout_revival/utils/menu_button.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'Game Over',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Score: ${game.score}',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Level: ${game.levelManager.currentLevel}',
                  style: const TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 20.0,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              build3DButton(
                'Play Again',
                onPressed: () {
                  game.overlays.remove(GameOverMenu.ID);
                  game.resetGame();
                  game.resumeEngine();
                },
              ),
              SizedBox(height: 20),
            
          build3DButton(
            'Main Menu',
            onPressed: () {
              game.overlays.remove(PauseMenu.ID);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MenuScreen(),
              ));
            },
          ),
            ],
          ),
        ),
      ),
    );
  }
}
