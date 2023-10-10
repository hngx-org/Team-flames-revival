import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/widgets.dart';

JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 10,
    paint: BasicPalette.red.withAlpha(200).paint(),
  ),
  background: CircleComponent(
    radius: 50,
     paint: BasicPalette.red.withAlpha(100).paint(),
  ),
  margin: EdgeInsets.only(left: 20, bottom: 20),
);
