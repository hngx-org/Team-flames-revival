import 'package:audioplayers/audioplayers.dart';
import 'package:breakout_revival/game/breakout_revival_game.dart';
import 'package:breakout_revival/screens/menu_screen.dart';
import 'package:breakout_revival/utils/menu_button.dart';
import 'package:breakout_revival/utils/pause_button.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class PauseMenu extends StatefulWidget {
  static const String ID = 'PauseMenu';
  BreakoutGame game;
  PauseMenu({super.key, required this.game});

  @override
  State<PauseMenu> createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  bool isSoundOn = true;
  // _toggleSound() {
  //   setState(() {
  //     isSoundOn = !isSoundOn;
  //   });
  //   widget.game.backgroundMusic();
  // }

  @override
  void initState() {
    super.initState();
    widget.game.backgroundMusic();
  }

  @override
  dispose() async {
    super.dispose();
    widget.game.backgroundMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Text(
              'Paused',
              style: TextStyle(
                fontSize: 50,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.black,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Score: ${widget.game.score}',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.black,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Level: ${widget.game.level}',
              style: const TextStyle(
                fontSize: 50,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.black,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          build3DButton(
            'Resume',
            onPressed: () {
              widget.game.resumeEngine();
              widget.game.overlays.remove(PauseMenu.ID);
              widget.game.overlays.add(PauseButton.ID);
            },
          ),
          const SizedBox(height: 20),
          build3DButton(
            'Main Menu',
            onPressed: () {
              widget.game.overlays.remove(PauseMenu.ID);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MenuScreen(),
              ));
            },
          ),
          const SizedBox(height: 20),
          build3DButton(
            isSoundOn ? 'Music Off' : 'Music On',
            // label: isSoundOn ? 'Sound Off' : 'Sound On',
            onPressed: () {
              setState(() {
                if(isSoundOn){
                  widget.game.backgroundMusic();
                }
                if (isSoundOn=false) {
                  widget.game.backgroundMusic();
                }
              });
              
            },
          )
        ],
      ),
    );
  }
}
