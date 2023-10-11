import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';

class BrickComponent extends PositionComponent with HasGameRef<BreakoutGame> {
  final double _brickSize = 30.0;

  @override
  Future<void> onLoad() async {
    // Load all four brick sprites
    final firstBrick = await gameRef.loadSprite(Globals.firstBrickSprite);
    final secondBrick = await gameRef.loadSprite(Globals.secondBrickSprite);
    final thirdBrick = await gameRef.loadSprite(Globals.thirdBrickSprite);
    final fourthBrick = await gameRef.loadSprite(Globals.fourthBrickSprite);

    final brickWidth = _brickSize;
    final brickHeight = _brickSize;

    final numberOfBricksPerRow = (gameRef.size.x / brickWidth).floor();
    final brickSprites = [firstBrick, secondBrick, thirdBrick, fourthBrick];

    for (int row = 0; row <= 3; row++) {
      double xOffset = 0.0;

      for (int column = 0; column < numberOfBricksPerRow; column++) {
        final brickSprite = brickSprites[row % brickSprites.length];

        final brick = SpriteComponent(
          sprite: brickSprite,
          size: Vector2(brickWidth, brickHeight),
          position: Vector2(xOffset + 10, row * brickHeight + 15),
        );

        add(brick);
        xOffset += brickWidth;
      }
    }
  }
}
