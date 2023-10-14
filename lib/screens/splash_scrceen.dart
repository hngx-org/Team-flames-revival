import 'package:breakout_revival/screens/menu_screen.dart';
import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _navigateToHome();
   
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/atari_splash.png'),
            fit: BoxFit.fill,
          ),
        ),
        
      ),
    );
  }
}
