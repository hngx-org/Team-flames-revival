import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../levels.dart';

class BrickComponent extends PositionComponent with HasGameRef<BreakoutGame> {
  final double _brickSize = 30.0;
  int totalBricks = 30; // Initial total number of bricks

  late SharedPreferences _prefs;
  LevelManager? _levelManager;

  // Factory constructor to perform async initialization
  factory BrickComponent(LevelManager levelManager) {
    final brickComponent = BrickComponent._();
    brickComponent._initialize(levelManager);
    return brickComponent;
  }

  // Private constructor
  BrickComponent._();

  void _initialize(LevelManager levelManager) async {
    _levelManager = levelManager;
    _prefs = await SharedPreferences.getInstance();

    final brickSprites = [
      await gameRef.loadSprite(Globals.firstBrickSprite),
      await gameRef.loadSprite(Globals.secondBrickSprite),
      await gameRef.loadSprite(Globals.thirdBrickSprite),
      await gameRef.loadSprite(Globals.fourthBrickSprite),
    ];

    final bricks = <SpriteComponent>[];
    final currentLevel = _levelManager!.currentLevel;

    final brickArrangement = _levelManager!.getBrickArrangementForLevel(currentLevel);

    double totalBricksWidth = brickArrangement[0].length * _brickSize * 1.5;

    // Calculate the horizontal offset to center the bricks
    double xOffset = (gameRef.size.x - totalBricksWidth) / 2;

    // Vertical shift
    double yOffset = 30;

    for (int i = 0; i < brickArrangement.length; i++) {
      final row = brickArrangement[i];
      for (int j = 0; j < row.length; j++) {
        if (row[j] == 1) {
          // Cycle through brick sprites
          final brickLevel = currentLevel;
          final brickSprite = brickSprites[brickLevel % brickSprites.length];

          final brick = SpriteComponent(
            sprite: brickSprite,
            size: Vector2(_brickSize, _brickSize),
          );

          brick.position = Vector2(
            j * _brickSize * 1.5 + xOffset,
            i * _brickSize * 0.866 + yOffset, // Apply vertical shift
          );

          bricks.add(brick);
        }
      }
    }

    bricks.shuffle();

    for (int i = 0; i < bricks.length; i++) {
      final brick = bricks[i];
      add(brick);
    }
  }

  void reload() {
    for (final component in children.toList()) {
      if (component is BrickComponent) {
        remove(component);
      }
    }

    _initialize(_levelManager!);
  }
}
