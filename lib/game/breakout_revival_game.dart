import 'dart:async';
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
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BreakoutGame extends FlameGame with HasCollisionDetection, DragCallbacks {
  int score = 0;
  int remainingBricks = 0;
  late TextComponent _scoreText;
  // late TextComponent _timeText; // Add a TextComponent for the survival time
  PaddleComponent paddleComponent = PaddleComponent(joystick: joystick);
  late BrickComponent brickComponent;
  BallComponent ballComponent = BallComponent();

  bool gamePaused = false;
  bool isSoundOn = true;
  int survivalTime = 0; // Add a survival time counter
  int maxSurvivalTime = 300; // 5 minutes in seconds

  late Timer timer; // Add a timer

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());
    add(joystick);
    add(paddleComponent);

    brickComponent = BrickComponent();

    add(brickComponent);
    add(ballComponent);

    FlameAudio.audioCache.loadAll([
      Globals.brickeffect1,
      Globals.brickeffect2,
      Globals.brickeffect2,
      Globals.brickeffect3,
      Globals.brickeffect4,
      Globals.screeneffect,
      Globals.backgroundMusic,
    ]);

    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play(Globals.backgroundMusic);

    _scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(20, 20),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: TextStyle(color: BasicPalette.white.color, fontSize: 20),
      ),
    );

    // _timeText = TextComponent(
    //   // Create the TextComponent for the survival time
    //   text: Timer(Duration(minutes: 5) as double).toString(), // Initialize with 00:00
    //   position: Vector2(20, 60), // Position it below the score
    //   anchor: Anchor.topLeft,
    //   textRenderer: TextPaint(
    //     style: TextStyle(color: BasicPalette.white.color, fontSize: 20),
    //   ),
    // );

    add(_scoreText);
    // add(_timeText); // Add the survival time TextComponent

    add(ScreenHitbox());
    resetGame();
    backgroundMusic();
    startTimer(); // Start the timer
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!gamePaused) {
      _scoreText.text = 'Score: $score';

      if (ballComponent.position.y > size.y ||
          survivalTime >= maxSurvivalTime) {
        gamePaused = true;
        overlays.add(GameOverMenu.ID);
        timer.finished; // Stop the timer
      }
    }
  }

  void backgroundMusic() async {
    if (isSoundOn) {
      await FlameAudio.bgm.resume();
    }
  }

  void stopBackgroundMusic() async {
    if (isSoundOn = !isSoundOn) {
      await FlameAudio.bgm.pause();
    }
  }

  void resetGame() {
    brickComponent.reload();
    score = 0;
    ballComponent.resetPosition();
    paddleComponent.resetPosition();
    remainingBricks = brickComponent.children.length;
    gamePaused = false;
    survivalTime = 0;
  }

  void updateSurvivalTimeText() {
    final minutes = (survivalTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (survivalTime % 60).toString().padLeft(2, '0');
    // _timeText.text = 'Time: $minutes:$seconds';
  }

  void startTimer() {
    void updateTimer() {
      if (survivalTime >= maxSurvivalTime) {
        gamePaused = true;
        // You can add game over logic here
      } else {
        survivalTime++;
        updateSurvivalTimeText();
        Future.delayed(Duration(seconds: 1), updateTimer);
      }
    }

    updateTimer();
  }
}
