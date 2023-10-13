import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';

class PaddleComponent extends SpriteComponent with HasGameRef<BreakoutGame> {
  final double _spriteHeight = 30;
  bool movingRight = true;
  double speed = 10.0;

  JoystickComponent joystick;


  PaddleComponent({required this.joystick});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Globals.paddleSprite);
    height = _spriteHeight;
    width = _spriteHeight * 5.5;
    anchor = Anchor.center;

    position = Vector2(
        gameRef.size.x / 2 - width / 6 + 25, gameRef.size.y - height - 10);

    joystick.position = position - Vector2(40, 60);

    // Attach the joystick to the game
    gameRef.add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Check joystick input for paddle movement
    if (joystick != null) {
      final direction = joystick.direction;
      if (direction != JoystickDirection.idle) {
        // Adjust the speed according to your preference
        double joystickSpeed = 15.0;
        if (direction == JoystickDirection.right) {
          position.x += joystickSpeed;
        } else if (direction == JoystickDirection.left) {
          position.x -= joystickSpeed;
        }
      }
    }

    // Clamp paddle position within the screen bounds
    position.x = position.x.clamp(
      width / 2,
      gameRef.size.x - width / 2,
    );

    // Check if the paddle is at the screen edge
    if (position.x + width / 2 > gameRef.size.x) {
      movingRight = false;
    } else if (position.x - width / 2 < 0) {
      movingRight = true;
    }
  }

  void resetPosition() {
    position = Vector2(
        gameRef.size.x / 2 - width / 6 + 25, gameRef.size.y - height - 10);
  }
}
