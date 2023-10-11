import 'package:breakout_revival/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5), () {
      // Navigate to game's home screen or main menu after 5 seconds
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            MenuScreen(), // Replace with your game's main screen
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/animations/breakout_animation.json'),
      ),
    );
  }
}
