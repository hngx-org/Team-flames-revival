import 'package:breakout_revival/components/background_component.dart';
import 'package:breakout_revival/components/sprites/ball_component.dart';
import 'package:breakout_revival/components/sprites/brick_sprite.dart';
import 'package:breakout_revival/components/sprites/paddle_sprite.dart';
import 'package:breakout_revival/input/joystick.dart';

import 'package:breakout_revival/screens/game_over_screen.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:audioplayers/audioplayers.dart'; // Added this import
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BreakoutGame extends FlameGame with DragCallbacks, HasCollisionDetection {
  int score = 0;
  int level = 0; // Current level
  int remainingBricks = 0; // Number of remaining bricks
  late TextComponent _scoreText;
  late TextComponent _levelText;
  PaddleComponent paddleComponent = PaddleComponent(joystick: joystick);
  BrickComponent brickComponent = BrickComponent();
  BallComponent ballComponent = BallComponent();

  bool gamePaused = false;
  bool isSoundOn = true;

  late AudioPlayer audioPlayer;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
    add(joystick);
    add(paddleComponent);
    add(brickComponent);
    add(ballComponent);

    // Load audio files using FlameAudio (not FlameAudio.audioCache)
    FlameAudio.audioCache.loadAll([
      Globals.brickeffect1,
      Globals.brickeffect2,
      Globals.brickeffect2,
      Globals.brickeffect3,
      Globals.brickeffect4,
      Globals.screeneffect,
    ]);

    // Initialize the audio player
    audioPlayer = AudioPlayer();

    _scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(20, 20),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: BasicPalette.white.color, fontSize: 20),
      ),
    );

    _levelText = TextComponent(
      text: 'Level: $level',
      position: Vector2(20, 60),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: BasicPalette.white.color, fontSize: 30),
      ),
    );

    add(_scoreText);
    add(_levelText);
    add(ScreenHitbox());
    resetGame();
    checkBrickClearance();
    FlameAudio.playLongAudio(Globals.backgroundMusic);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!gamePaused) {
      _scoreText.text = 'Score: $score';
      if (ballComponent.position.y > size.y) {
        gamePaused = true;
        overlays.add(GameOverMenu.ID);
      }
    }
  }

  void backgroundMusic() async {
    if (isSoundOn) {
      if (audioPlayer.state == PlayerState.playing) {
        await audioPlayer.play(AssetSource(Globals.backgroundMusic));
      }
    }
    if (isSoundOn = false) {
      await audioPlayer.stop();
    }
  }

  void checkBrickClearance() {
    if (remainingBricks == 0) {
      level++;
      _levelText.text = 'Level: $level';
      resetGame();
    }
  }

  void resetGame() {
    brickComponent.reload();
    score = 0;
    ballComponent.resetPosition();
    paddleComponent.resetPosition();
    remainingBricks = brickComponent.children.length;
    gamePaused = false;
  }
}
