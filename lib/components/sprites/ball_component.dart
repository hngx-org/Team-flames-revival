import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class BallComponent extends SpriteComponent
    with HasGameRef<BreakoutGame>, CollisionCallbacks {
  final double _spriteDiameter = 30;
  double speed = 150.0;
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
      // ogic to change the horizontal velocity based on where it hits the paddle
      velocity.x = velocity.x + 2;
    } else {
      for (final brick in bricks) {
        final brickRect = brick.toRect();
        if (ballRect.overlaps(brickRect)) {
          // Collision with a brick
          game.brickComponent.remove(brick);
          game.score += 1;
          // Reverse the vertical velocity
          velocity.y = -velocity.y;
          // You can also add logic to change the horizontal velocity
          // Remove the brick from the game
        }
      }
    }

    // Check for collisions with screen boundaries
    if (position.x <= 0 || position.x >= game.size.x - width) {
      velocity.x = -velocity.x;
    }

    if (position.y <= 0) {
      velocity.y = -velocity.y;
    }

    // End game condition (ball out of screen)
    if (position.y >= game.size.y) {
      game.resetGame();
    }
  }

  void resetPosition() {
    position = Vector2(
      (gameRef.size.x - _spriteDiameter) / 2,
      (gameRef.size.y - _spriteDiameter) / 2,
    );

    // You can also reset the velocity to its initial state if needed
    velocity = Vector2(1.0, 1.0);
  }
}
