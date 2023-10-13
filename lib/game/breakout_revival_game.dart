import 'package:breakout_revival/components/background_component.dart';
import 'package:breakout_revival/components/sprites/ball_component.dart';
import 'package:breakout_revival/components/sprites/brick_sprite.dart';
import 'package:breakout_revival/components/sprites/paddle_sprite.dart';
import 'package:breakout_revival/input/joystick.dart';
import 'package:breakout_revival/screens/game_over_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BreakoutGame extends FlameGame with DragCallbacks, HasCollisionDetection {
  int score = 0;
  int level = 1; // Current level
  int remainingBricks = 0; // Number of remaining bricks

  late TextComponent _scoreText;
  late TextComponent _levelText;

  PaddleComponent paddleComponent = PaddleComponent(joystick: joystick);
  BrickComponent brickComponent = BrickComponent();
  BallComponent ballComponent = BallComponent();

  bool gamePaused = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());

    add(brickComponent);

    add(ballComponent);

    add(joystick);

    add(paddleComponent);

    _scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(20, 20),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: BasicPalette.white.color, fontSize: 30),
      ),
    );

    add(_scoreText);

    _levelText = TextComponent(
      text: 'Level: $level',
      position: Vector2(20, 60), // Adjust the position as needed
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: BasicPalette.white.color, fontSize: 30),
      ),
    );

    add(_levelText);

    add(ScreenHitbox());

    resetGame();
  }

  @override
  void update(double dt) {
    if (!gamePaused) {
      super.update(dt);

      _scoreText.text = 'Score: $score';

      // Check if the ball has fallen off the screen
      if (ballComponent.position.y > size.y) {
        gamePaused = true;
        overlays.add(GameOverMenu.ID);
      }
    }
  }

  // Function to check if all bricks are cleared and advance to the next level
  void checkBrickClearance() {
    if (remainingBricks == 0) {
      // All bricks are cleared, advance to the next level
      level++;
      _levelText.text = 'Level: $level';

      // You can add more logic here to change the level's properties, like increasing the ball speed, etc.

      // Reset the game for the new level
      resetGame();
    }
  }

  void resetGame() {
    // Clear bricks
    brickComponent.reload();

    // Reset the score
    score = 0;

    // Reset the ball's position
    if (ballComponent != null) {
      ballComponent.resetPosition();
    }
    // Reset the paddle's position
    if (ballComponent != null) {
      paddleComponent.resetPosition();
    }

    // Update the remaining bricks count
    remainingBricks = brickComponent.children.length;

    gamePaused = false;
  }
}
