import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/screens/menu_screen.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GameWidget(game: BreakoutGame()));
}
