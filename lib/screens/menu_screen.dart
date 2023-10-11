import 'package:breakout_revival/components/menu_button.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:lottie/lottie.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;
  late Animation<Offset> _offsetAnimation3;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller2 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller3 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation1 = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeOut,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeOut,
    ));

    _offsetAnimation3 = Tween<Offset>(
      begin: Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeOut,
    ));

    _controller1.forward();
    Future.delayed(Duration(milliseconds: 900), () => _controller2.forward());
    Future.delayed(Duration(milliseconds: 1300), () => _controller3.forward());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menu_img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _offsetAnimation1,
                child: build3DButton(
                  'Begin',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GameWidget(
                                game: BreakoutGame(),
                              )),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              SlideTransition(
                position: _offsetAnimation2,
                child: build3DButton('How to Play'),
              ),
              SizedBox(height: 20),
              SlideTransition(
                  position: _offsetAnimation3, child: build3DButton('Close')),
                  // Lottie.network('https://lottie.host/a432a44b-e8b1-41f6-9dad-76f3db07b760/kra5G5FHZR.json')
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }
}
