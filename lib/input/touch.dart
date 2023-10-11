import 'dart:ui';

import 'package:breakout_revival/components/sprites/paddle_sprite.dart';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/gestures.dart';

class Touch extends Game with HorizontalDragDetector {
  final PaddleComponent paddle;

  Touch(this.paddle);

  void onDragUpdate(DragUpdateDetails event) {
    // Handle the drag update event here
    // You can access the horizontal movement using event.localPosition.dx
    // Adjust the paddle position based on the drag update.
    paddle.x += event.localPosition.dx;
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
  }

  @override
  void update(double dt) {
    // TODO: implement update
  }
}
