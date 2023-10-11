import 'dart:async';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class PaddleComponent extends SpriteComponent with HasGameRef<BreakoutGame> {
  final double _spriteHeight = 30;
  bool movingRight = true;
  double speed = 2.0; 

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

    if (movingRight) {
      position.x += speed;
    } else {
      position.x -= speed;
    }

    // Check if the paddle is at the screen edge
    if (position.x + width / 2 > gameRef.size.x) {
      // If the right edge is reached, change direction to the left
      movingRight = false;
    } else if (position.x - width / 2 < 0) {
      // If the left edge is reached, change direction to the right
      movingRight = true;
    }
  }
}
