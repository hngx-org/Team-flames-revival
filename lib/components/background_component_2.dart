import 'dart:async';

import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/utils/games_constant.dart';
import 'package:flame/components.dart';

class BackgroundComponent2 extends SpriteComponent
    with HasGameRef<BreakoutGame> {
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Globals.backgroundSprite2);
    size = gameRef.size;
  }
}
