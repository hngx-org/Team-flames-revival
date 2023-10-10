import 'dart:async';

import 'package:breakout_revival/components/background_component.dart';
import 'package:breakout_revival/components/sprites/paddle_sprite.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BreakoutGame extends FlameGame with DragCallbacks, CollisionCallbacks {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());

    add(PaddleComponent());
  }
}
