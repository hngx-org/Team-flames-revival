import 'dart:math';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../levels.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<BreakoutGame>, CollisionCallbacks {
  final double _spriteDiameter = 15;
  double speed = 70.0;
  Vector2 velocity = Vector2(1.0, 1.0);

  LevelManager _levelManager = LevelManager();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.ballSprite);
    width = _spriteDiameter;
    height = _spriteDiameter;
    anchor = Anchor.center;

    position = Vector2(
      (gameRef.size.x - _spriteDiameter) / 2,
      (gameRef.size.y - _spriteDiameter) / 2,
    );
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * speed * dt;

    // Check for collisions with bricks and paddle
    final game = gameRef;
    final paddle = game.paddleComponent;
    final bricks = game.brickComponent.children.whereType<SpriteComponent>();

    final ballRect = toRect();
    final paddleRect = paddle.toRect();

    if (ballRect.overlaps(paddleRect)) {
      // Collision with paddle
      // Reverse the vertical velocity
      velocity.y = -velocity.y;
      // Logic to change the horizontal velocity based on where it hits the paddle
      velocity.x = velocity.x;
    } else {
      for (final brick in bricks.toList()) {
        final brickRect = brick.toRect();
        if (ballRect.overlaps(brickRect)) {
          // Collision with a brick
          game.brickComponent.remove(brick);
          game.score += 1;

          if (game.remainingBricks == 0 && _levelManager.currentLevel != 10) {
            // All bricks removed

            game.checkBrickClearance();
          } else {
            game.pauseEngine();
          }

          // Reverse the vertical velocity
          velocity.y = -velocity.y;
          // Reverse the horizontal velocity
          velocity.x = -velocity.x;
        }
      }
    }

    // Check if the level needs to be incremented
    if (_levelManager.currentLevel != game.levelManager) {
      game.levelManager = _levelManager;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;

      if (collisionPoint.x == 0 || collisionPoint.x == game.size.x) {
        velocity.x = -velocity.x;
        FlameAudio.play(Globals.screeneffect);
      }
      if (collisionPoint.y == 0) {
        velocity.y = -velocity.y;
        FlameAudio.play(Globals.screeneffect);
      }
    }
  }

  void resetPosition() {
    position = Vector2(
      (game.size.x - _spriteDiameter) / 2,
      (game.size.y - _spriteDiameter) / 2,
    );

    // You can also reset the velocity to its initial state if needed
    velocity = Vector2(1.0, 1.0);
  }
}
