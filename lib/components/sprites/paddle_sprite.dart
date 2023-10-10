import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PaddleComponent extends SpriteComponent
    with HasGameRef<BreakoutGame>, DragCallbacks {
  final double _spriteHeight = 30;
  double velocity = 0; // Initialize velocity
  double friction = 0.95; // Adjust the friction factor (0.0 to 1.0)
  double maxVelocity = 200.0; // Adjust the maximum velocity

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.paddleSprite);
    height = _spriteHeight;
    width = _spriteHeight * 5.5;
    anchor = Anchor.center;

    position = Vector2(
        gameRef.size.x / 2 - width / 6 + 25, gameRef.size.y - height - 10);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Apply friction to gradually slow down the paddle
    velocity *= friction;

    // Update the paddle's position based on velocity
    position.x += velocity * dt;

    // Ensure the paddle stays within screen bounds
    if (position.x < 0) {
      position.x = 0;
    } else if (position.x + width > gameRef.size.x) {
      position.x = gameRef.size.x - width;
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    double dx = details.delta.dx;

    // Adjust the velocity based on drag input
    velocity += dx;

    // Limit the maximum speed of the paddle (optional)
    if (velocity.abs() > maxVelocity) {
      velocity = maxVelocity * (velocity / velocity.abs());
    }
  }
}
