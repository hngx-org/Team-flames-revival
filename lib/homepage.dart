import 'dart:async';
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

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  //ball variables
  double ballX = 0;
  double ballY = 0;

  //player variables
  double playerX = -0.2;
  double playerWidth = 0.4; //out of 2;
  double ballXIncrement = 0.01;
  double ballYIncrement = 0.01;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  //ball direction
  var ballDirection = direction.DOWN;

  //bricks variables
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double brickWidth = 0.4; //out of 2
  static double brickHeight = 0.05; //out of 2
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  List myBricks = [
    // [x,y,broken = true/false]
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
  ];
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
    for (int i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY <= myBricks[i][1] + brickHeight &&
          myBricks[i][2] == false) {
        setState(() {
          myBricks[i][2] = true;

          double leftSideDist = (myBricks[i][0] - ballX).abs();
          double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
          double topSideDist = (myBricks[i][1] - ballY).abs();
          double bottomSideDist = (myBricks[i][1] + brickHeight - ballY).abs();
          //  ballYDirection = direction.UP; since ball is moving in y direction
          String min =
              findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);
          switch (min) {
            case 'left':
              ballXDirection = direction.LEFT;

              break;
            case 'right':
              ballXDirection = direction.RIGHT;

              break;
            case 'top':
              ballYDirection = direction.UP;

              break;
            case 'bottom':
              ballYDirection = direction.DOWN;

              break;

            default:
          }
        });
      }
    }
  }

// find min distance from ball to brick
  String findMin(double a, double b, double c, double d) {
    List<double> myList = [a, b, c, d];
    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }
    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'top';
    } else if ((currentMin - d).abs() < 0.01) {
      return 'bottom';
    }

    return '';
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
      //move ball in x direction
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXIncrement;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXIncrement;
      }
      // move ball in y direction
      if (ballYDirection == direction.DOWN) {
        ballY += ballYIncrement;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYIncrement;
      }
    });
  }

  void updateDirection() {
    setState(() {
      //update ball x direction   when ball hits the left wall
      if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      }
      //update ball x direction when ball hits the right wall
      else if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      }
      // update ball y direction  when ball hits the player or paddle
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = direction.UP;
      }
      //update ball y direction when ball hits the brick or top of screen
      else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
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
  void resetGame (){
    // only move right if moving right doesn't move paddlel off the screen
    print("reset game >>>>>>>>");
  setState(() {
    isGameOver = false;
    hasStartGame = false;
    playerX = -0.2;
    ballY = 0;
    ballX = 0;
       myBricks = [
        // [x,y,broken = true/false]
        [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
      ];
      
  });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => startGame(),
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx < 0) {
          moveLeft();
        } else if (details.delta.dx > 0) {
          moveRight();
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Stack(
              children: [
                //Tap to play
                CoverScreen(
                  tapToPlay: hasStartGame,
                  isGameOver: isGameOver,
                  hasGameStarted: hasStartGame,
                ),
                //game over screen
                GameOverScreen(
                  isGameOver: isGameOver,
                  function:(){
                    resetGame();
                  } ,
                ),
                //ball
                MyBall(
                  ballX: ballX, 
                  ballY: ballY,
                  // hasGameStarted: hasStartGame,
                  // isGameOver: isGameOver,
                  ),
                //Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),
                MyBrick(
                  brickX: myBricks[0][0],
                  brickY: myBricks[0][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[0][2],
                ),
                MyBrick(
                  brickX: myBricks[1][0],
                  brickY: myBricks[1][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[1][2],
                ),
                MyBrick(
                  brickX: myBricks[2][0],
                  brickY: myBricks[2][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[2][2],
                ),
                // MyBrick(
                //   brickX: myBricks[3][0],
                //   brickY: myBricks[3][1],
                //   brickWidth: brickWidth,
                //   brickHeight: brickHeight,
                //   brickBroken: myBricks[3][2],
                // ),
                // MyBrick(
                //   brickX: myBricks[4][1],
                //   brickY: myBricks[4][2],
                //   brickWidth: brickWidth,
                //   brickHeight: brickHeight,
                //   brickBroken: myBricks[4][2],
                // ),
                // MyBrick(
                //   brickX: myBricks[5][0],
                //   brickY: myBricks[5][1],
                //   brickWidth: brickWidth,
                //   brickHeight: brickHeight,
                //   brickBroken: myBricks[5][2],
                // ),
                // MyBrick(
                //   brickX: myBricks[6][0],
                //   brickY: myBricks[6][1],
                //   brickWidth: brickWidth,
                //   brickHeight: brickHeight,
                //   brickBroken: myBricks[6][2],
                // ),
                // MyBrick(
                //   brickX: myBricks[7][0],
                //   brickY: myBricks[7][1],
                //   brickWidth: brickWidth,
                //   brickHeight: brickHeight,
                //   brickBroken: myBricks[7][2],
                // ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
