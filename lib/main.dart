import 'package:breakout_revival/screens/level_screen.dart';
import 'package:breakout_revival/screens/power_up_screen.dart';
import 'package:breakout_revival/screens/splash_scrceen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Breakout Game',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
