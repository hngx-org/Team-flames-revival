import 'dart:math';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../levels.dart';

class BrickComponent extends PositionComponent with HasGameRef<BreakoutGame> {
  final double _brickSize = 30.0;
  int totalBricks = 30; // Initial total number of bricks

  SharedPreferences? _prefs;
  LevelManager? _levelManager;

  BrickComponent(LevelManager levelManager) {
    _levelManager = levelManager;
  }

  @override
  Future<void> onLoad() async {
    _prefs = await SharedPreferences.getInstance();

    final brickSprites = [
      await gameRef.loadSprite(Globals.firstBrickSprite),
      await gameRef.loadSprite(Globals.secondBrickSprite),
      await gameRef.loadSprite(Globals.thirdBrickSprite),
      await gameRef.loadSprite(Globals.fourthBrickSprite),
    ];

    int bricksAdded = 0;
    int rowOffset = 0;
    int maxColumns =
        sqrt(totalBricks).ceil(); // Calculate the maximum number of columns

    while (bricksAdded < totalBricks) {
      for (int column = 0; column < maxColumns; column++) {
        if (bricksAdded >= totalBricks) {
          break;
        }

        final brickLevel = _levelManager!.currentLevel;

        // Determine the sprite based on the current level
        final brickSprite = brickSprites[brickLevel % brickSprites.length];

        final xOffset = (gameRef.size.x - maxColumns * _brickSize * 1.5) /
            2; // Center the bricks horizontally
        final yOffset =
            (gameRef.size.y - (rowOffset + 1) * _brickSize * 0.866) /
                2; // Center the bricks vertically

        final brick = SpriteComponent(
          sprite: brickSprite,
          size: Vector2(_brickSize, _brickSize),
          position: Vector2(
            xOffset + column * _brickSize * 1.5,
            yOffset +
                rowOffset *
                    _brickSize *
                    0.866, // Adjust vertical positioning for hexagonal shape
          ),
        );

        add(brick);
        bricksAdded++;
      }

      rowOffset++;
    }
  }

  void reload() {
    for (final component in children.toList()) {
      if (component is BrickComponent) {
        remove(component);
      }
    }

    onLoad();
  }
}
