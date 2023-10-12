import 'dart:async';

import 'package:breakout_revival/components/background_component.dart';
import 'package:breakout_revival/components/sprites/ball_component.dart';
import 'package:breakout_revival/components/sprites/brick_sprite.dart';
import 'package:breakout_revival/components/sprites/paddle_sprite.dart';
import 'package:breakout_revival/input/tap.dart';
import 'package:breakout_revival/input/touch.dart';
import 'package:breakout_revival/screens/game_over_screen.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BreakoutGame extends FlameGame with DragCallbacks, CollisionCallbacks {
  PaddleComponent paddleComponent = PaddleComponent(joystick: joystick);
  BrickComponent brickComponent = BrickComponent();

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());

    add(brickComponent);

    add(BallComponent());

    add(joystick);

    add(paddleComponent);
  }

  void gameOver() {
    // Implement your game over logic here.
    // You can add code to show the game over screen, reset the game, or perform any other necessary actions.
    // For example:
    // 1. Show the game over screen
    final gameOverScreen = GameOverScreen();
    this.overlays.add(gameOverScreen);

    // 2. Reset the game or perform any other necessary actions
    // Reset the ball's position, paddle, and bricks, and prepare for a new game.
    resetGame();
  }

  // You can also add other game-related methods or logic here.
  void resetGame() {
    // Implement the logic to reset the game, such as repositioning the ball, resetting scores, and other game-related data.
  }
}
