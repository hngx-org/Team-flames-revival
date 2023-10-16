import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<BreakoutGame>, CollisionCallbacks {
  final double _spriteDiameter = 30;
  double speed = 70.0;
  Vector2 velocity = Vector2(1.0, 1.0);

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
          // Reverse the vertical velocity
          velocity.y = -velocity.y;
          // You can also add logic to change the horizontal velocity
          // Remove the brick from the game

          // Decrement the total brick count
          game.remainingBricks--;

          // Check if all bricks are cleared and advance to the next level
          if (game.remainingBricks == 0) {
            game.checkBrickClearance();
          }
        }
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;
      FlameAudio.play(Globals.screeneffect);

      if (collisionPoint.x == 0 || collisionPoint.x == game.size.x) {
        velocity.x = -velocity.x;
      }
      if (collisionPoint.y == 0) {
        velocity.y = -velocity.y;
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
