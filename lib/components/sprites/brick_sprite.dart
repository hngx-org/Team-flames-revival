import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';

class BrickComponent extends PositionComponent with HasGameRef<BreakoutGame> {
  final double _brickSize = 30.0;
  List<List<List<int>>> brickArrangements = [
    // Define your brick arrangements here
    [
      [1, 0, 1, 1, 0, 1, 1],
      [1, 1, 0, 1, 1, 0, 0],
      [1, 1, 0, 1, 0, 1, 0],
      [1, 1, 1, 1, 1, 0, 1],
      [0, 1, 1, 1, 0, 1, 1],
      [0, 1, 1, 1, 0, 1, 0],
    ],
    [
      [1, 1, 1, 1, 1, 1, 1],
      [1, 0, 1, 0, 1, 0, 1],
      [1, 1, 1, 1, 1, 1, 1],
      [0, 0, 1, 0, 1, 0, 0],
      [0, 1, 1, 1, 1, 1, 0],
      [0, 1, 0, 0, 0, 1, 0],
    ],
    [
      [1, 0, 0, 1, 0, 0, 1],
      [0, 1, 1, 0, 1, 1, 0],
      [1, 1, 1, 0, 1, 1, 1],
      [0, 0, 1, 1, 1, 0, 0],
      [0, 0, 1, 0, 1, 0, 0],
      [0, 1, 0, 1, 0, 1, 0],
    ],
    // Add more arrangements as needed
  ];

  int currentArrangementIndex = 0; // Index of the current arrangement

  // Factory constructor to create BrickComponent
  factory BrickComponent() {
    final brickComponent = BrickComponent._();
    brickComponent._initialize();
    return brickComponent;
  }

  // Private constructor
  BrickComponent._();

  void _initialize() async {
    final brickSprites = [
      await gameRef.loadSprite(Globals.firstBrickSprite),
      await gameRef.loadSprite(Globals.secondBrickSprite),
      await gameRef.loadSprite(Globals.thirdBrickSprite),
      await gameRef.loadSprite(Globals.fourthBrickSprite),
    ];

    final bricks = <SpriteComponent>[];

    List<List<int>> currentArrangement = brickArrangements[currentArrangementIndex];
    
    double totalBricksWidth = currentArrangement[0].length * _brickSize * 1.5;

    // Calculate the horizontal offset to center the bricks
    double xOffset = (gameRef.size.x - totalBricksWidth) / 2;

    // Vertical shift
    double yOffset = 30;

    for (int i = 0; i < currentArrangement.length; i++) {
      final row = currentArrangement[i];
      for (int j = 0; j < row.length; j++) {
        if (row[j] == 1) {
          // Cycle through brick sprites
          final brickSprite = brickSprites[i % brickSprites.length];

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

    // Shuffle the bricks
    bricks.shuffle();

    for (int i = 0; i < bricks.length; i++) {
      final brick = bricks[i];
      add(brick);
    }
  }

  void switchArrangement(int newIndex) {
    if (newIndex >= 0 && newIndex < brickArrangements.length) {
      currentArrangementIndex = newIndex;
      reload();
    }
  }

  void reload() {
    for (final component in children.toList()) {
      if (component is SpriteComponent) {
        remove(component);
      }
    }

    _initialize();
  }
}
