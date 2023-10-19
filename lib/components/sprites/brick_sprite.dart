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

    for (int i = 0; i < brickArrangement.length; i++) {
      final row = brickArrangement[i];
      for (int j = 0; j < row.length; j++) {
        if (row[j] == 1) {
          final brickLevel = currentLevel;
          final brickSprite = brickSprites[brickLevel % brickSprites.length];

          final brick = SpriteComponent(
            sprite: brickSprite,
            size: Vector2(_brickSize, _brickSize),
          );

          brick.position = Vector2(
            j * _brickSize * 1.5,
            i * _brickSize * 0.866,
          );

          bricks.add(brick);
        }
      }
    }

    // Shuffle the bricks to arrange them in a random order
    bricks.shuffle();

    double xOffset = (gameRef.size.x - bricks.length * _brickSize * 1.5) / 2;

    for (int i = 0; i < bricks.length; i++) {
      final brick = bricks[i];
      brick.position += Vector2(xOffset, 20);
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