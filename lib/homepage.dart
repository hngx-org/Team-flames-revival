import 'dart:async';
import 'dart:html';

import 'package:breakout/ball.dart';
import 'package:breakout/brick.dart';
import 'package:breakout/coverscreen.dart';
import 'package:breakout/gameoverscreen.dart';
import 'package:breakout/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN }

class _HomePageState extends State<HomePage> {
  //ball variables
  double ballX = 0;
  double ballY = 0;

  //player variables
  double playerX = -0.2;
  double playerWidth = 0.4; //out of 2;

  //ball direction
  var ballDirection = direction.DOWN;

  //bricks variables
  double brickX = 0;
  double brickY = -0.9;
  double brickWidth = 0.4; //out of 2
  double brickHeight = 0.05; //out of 2
  bool brickBroken = false;

  //start game variable
  bool hasStartGame = false;
  bool isGameOver = false;

  void startGame() {
    print("Hello");
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //update direction
      updateDirection();

      //move ball
      moveBall();

      //check if player dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      //check if bick is hit
      checkForBrokenBricks();
    });
  }

  void checkForBrokenBricks() {
    if (ballX >= brickX &&
        ballX <= brickWidth + brickX &&
        ballY <= brickY + brickHeight &&
        brickBroken == false) {
      setState(() {
        brickBroken = true;
        ballDirection = direction.DOWN;
      });
    }
  }

  //is player dead
  bool isPlayerDead() {
    // player dies if ball reaches the bottom of screen
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (ballDirection == direction.DOWN) {
        ballY += 0.01;
      } else if (ballDirection == direction.UP) {
        ballY -= 0.01;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballDirection = direction.UP;
      } else if (ballY <= -1) {
        ballDirection = direction.DOWN;
      }
    });
  }

  void moveLeft() {
    setState(() {
      //only move left if moving left doesn't move
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      //only move left if moving left doesn't move
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: () => startGame(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.deepPurple[100],
            body: Center(
              child: Stack(children: [
                //Tap to play
                CoverScreen(
                  tapToPlay: hasStartGame,
                ),
                //game over screen
                GameOverScreen(isGameOver: isGameOver),
                //ball
                MyBall(ballX: ballX, ballY: ballY),
                //Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),
                MyBrick(
                  brickX: brickX,
                  brickY: brickY,
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: brickBroken,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
