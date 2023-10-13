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
    // _controller = AnimationController(vsync: this)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       _navigateToHome();
    //     }
    //   });
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MenuScreen(),
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
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.end, // Position the child at the bottom
          children: [
            // Lottie.network(
            //   'https://lottie.host/a432a44b-e8b1-41f6-9dad-76f3db07b760/kra5G5FHZR.json',
            //   controller: _controller,
            //   onLoaded: (composition) {
            //     _controller
            //       ..duration = composition.duration
            //       ..forward();
            //   },
            // ),
            const SizedBox(height: 20), // Give some space at the bottom
          ],
        ),
      ),
    );
  }
}
