import 'package:breakout/homepage.dart';
import 'package:breakout/level_three.dart';
import 'package:breakout/level_two.dart';
import 'package:breakout/loading_screen.dart';
import 'package:breakout/splash_scrceen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atari Game',
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home: HomePage(),
      routes: {
        LevelTwo.routeName: (context) => LevelTwo(),
        LevelThree.routeName: (context) => LevelThree(),
      },
    );
  }
}
