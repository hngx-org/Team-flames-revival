import 'dart:async';

import 'package:breakout_revival/components/background_component.dart';
import 'package:breakout_revival/components/sprites/ball_component.dart';
import 'package:breakout_revival/components/sprites/brick_sprite.dart';
import 'package:breakout_revival/components/sprites/paddle_sprite.dart';

import 'package:breakout_revival/input/touch.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class BreakoutGame extends FlameGame with DragCallbacks, HasCollisionDetection {
  int score = 0;

  late TextComponent _scoreText;

  PaddleComponent paddleComponent =
      PaddleComponent(joystick: joystick, debugMode: true);
  BrickComponent brickComponent = BrickComponent();
  BallComponent ballComponent = BallComponent();

  @override
  FutureOr<void> onLoad() async {
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

    add(ScreenHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    _scoreText.text = 'Score: $score';
  }

  void resetGame() {
    // Clear bricks
    brickComponent.reload();

    // Reset the score
    score = 0;

    // Reset the ball's position
    ballComponent.resetPosition();
    // Reset the paddle's position
    paddleComponent.resetPosition();
  }
}
