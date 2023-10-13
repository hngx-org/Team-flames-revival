import 'package:audioplayers/audioplayers.dart';
import 'package:breakout_revival/components/menu_button.dart';
import 'package:breakout_revival/screens/breakout_game_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

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
  AudioPlayer audioPlayer = AudioPlayer();
  bool isSoundOn = true;

  Future<void> _playBackgroundMusic() async {
    if (isSoundOn) {
      print('sound is playing');
      await audioPlayer.play(
        AssetSource('sounds/game_over.wav'),
        volume: 0.8,
      );
    } else {
      print('sound is paused');
      audioPlayer.pause();
    }
  }

  _toggleSound() {
    setState(() {
      isSoundOn = !isSoundOn;
    });
    _playBackgroundMusic();
  }

  @override
  void initState() {
    super.initState();
    _playBackgroundMusic();
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
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.easeOut,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.easeOut,
    ));

    _offsetAnimation3 = Tween<Offset>(
      begin: const Offset(1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller3,
      curve: Curves.easeOut,
    ));

    _controller1.forward();
    Future.delayed(
        const Duration(milliseconds: 900), () => _controller2.forward());
    Future.delayed(
        const Duration(milliseconds: 1300), () => _controller3.forward());
  }

  @override
  dispose() async {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    await audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/menu_img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SlideTransition(
              position: _offsetAnimation1,
              child: build3DButton(
                'Begin',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BreakoutGameScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _offsetAnimation2,
              child: build3DButton(
                'How to Play',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      elevation: 10,
                      backgroundColor: const Color.fromARGB(255, 25, 7, 73),
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      title: Center(
                        child: Text(
                          'How to Play',
                          style: GoogleFonts.yujiSyuku(
                            color: const Color.fromARGB(255, 211, 128, 155),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      content: Text(
                          'Use the controller to move the paddle left and right of the screen. '
                          'The goal is to break all the bricks without letting the ball fall off the bottom of the screen. '
                          'You have 3 lives. '
                          'If you lose all 3 lives, you lose the game. '
                          'If you break all the bricks, you win the game. '
                          'Good luck!',
                          style: GoogleFonts.biryani(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                      actions: [
                        Center(
                          child: SizedBox(
                            width: 180,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 171, 207, 223)),
                              ),
                              child: Text('CLOSE',
                                  style: GoogleFonts.biryani(
                                    color: const Color.fromARGB(
                                        255, 229, 151, 177),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
                position: _offsetAnimation3,
                child: build3DButton(
                  isSoundOn ? 'Sound Off' : 'Sound On',
                  // label: isSoundOn ? 'Sound Off' : 'Sound On',
                  onPressed: () {
                    // Navigator.of(context).pop();
                    _toggleSound();
                  },
                )),
            // Lottie.asset('assets/lottie/atari_loader.json')
          ]),
        ),
      ),
    );
  }
}
