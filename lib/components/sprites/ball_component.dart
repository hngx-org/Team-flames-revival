import 'dart:async';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';

class BallComponent extends SpriteComponent with HasGameRef<BreakoutGame> {
  final double _spriteDiameter = 30; // Diameter of the circular sprite
  double speed = 2.0;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef
        .loadSprite(Globals.ballSprite); // Load your circular image here
    width = _spriteDiameter;
    height = _spriteDiameter;
    anchor = Anchor.center;

    position = Vector2(
      (gameRef.size.x - _spriteDiameter) / 2,
      (gameRef.size.y - _spriteDiameter) / 2,
    );
  }
}
