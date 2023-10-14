import 'dart:async';
import 'package:breakout/ball.dart';
import 'package:breakout/brick.dart';
import 'package:breakout/coverscreen.dart';
import 'package:breakout/gameoverscreen.dart';
import 'package:breakout/player.dart';
import 'package:flutter/material.dart';

enum direction { UP, DOWN, LEFT, RIGHT }

class HomePage extends StatefulWidget {
  HomePage();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.01;
  double ballYIncrement = 0.01;
  var ballYDirection = direction.DOWN;
  var ballXDirection = direction.LEFT;

  // Player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Ball direction
  var ballDirection = direction.DOWN;

  // Bricks variables
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  // New row of bricks position
  static double secondRowBrickX =
      -1 + wallGap; // Adjust the X position as needed
  static double secondRowBrickY =
      -0.9 + 0.06; // Adjust the Y position as needed
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 3;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  // Bricks list
  List myBricks = [
    // Existing bricks
    [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
    [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
    // New row of bricks
    [secondRowBrickX + 0 * (brickWidth + brickGap), secondRowBrickY, false],
    [secondRowBrickX + 1 * (brickWidth + brickGap), secondRowBrickY, false],
    [secondRowBrickX + 2 * (brickWidth + brickGap), secondRowBrickY, false],
  ];

  // Game variables
  bool hasStartGame = false;
  bool isGameOver = false;

  // Other methods

  void startGame() {
    print("Hello");
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // Update direction
      updateDirection();

      // Move ball
      moveBall();

      // Check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      // Check if brick is hit
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

          // Handle collision with bricks
          double leftSideDist = (myBricks[i][0] - ballX).abs();
          double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
          double topSideDist = (myBricks[i][1] - ballY).abs();
          double bottomSideDist = (myBricks[i][1] + brickHeight - ballY).abs();
          // Update ball direction based on collision
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

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == direction.LEFT) {
        ballX -= ballXIncrement;
      } else if (ballXDirection == direction.RIGHT) {
        ballX += ballXIncrement;
      }
      if (ballYDirection == direction.DOWN) {
        ballY += ballYIncrement;
      } else if (ballYDirection == direction.UP) {
        ballY -= ballYIncrement;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballX <= -1) {
        ballXDirection = direction.RIGHT;
      } else if (ballX >= 1) {
        ballXDirection = direction.LEFT;
      }
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = direction.UP;
      } else if (ballY <= -1) {
        ballYDirection = direction.DOWN;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerX - 0.2 < -1)) {
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerX + playerWidth >= 1)) {
        playerX += 0.2;
      }
    });
  }

  void resetGame() {
    setState(() {
      isGameOver = false;
      hasStartGame = false;
      playerX = -0.2;
      ballY = 0;
      ballX = 0;
      myBricks = [
        // Existing bricks
        [firstBrickX + 0 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 1 * (brickWidth + brickGap), firstBrickY, false],
        [firstBrickX + 2 * (brickWidth + brickGap), firstBrickY, false],
        // New row of bricks
        [secondRowBrickX + 0 * (brickWidth + brickGap), secondRowBrickY, false],
        [secondRowBrickX + 1 * (brickWidth + brickGap), secondRowBrickY, false],
        [secondRowBrickX + 2 * (brickWidth + brickGap), secondRowBrickY, false],
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
                // Background elements

                // Tap to play
                CoverScreen(
                  tapToPlay: hasStartGame,
                  isGameOver: isGameOver,
                  hasGameStarted: hasStartGame,
                ),

                // Game over screen
                GameOverScreen(
                  isGameOver: isGameOver,
                  function: () {
                    resetGame();
                  },
                ),

                // Ball
                MyBall(
                  ballX: ballX,
                  ballY: ballY,
                ),

                // Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                // Bricks
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

                // New row of bricks
                MyBrick(
                  brickX: myBricks[3][0],
                  brickY: myBricks[3][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[3][2],
                ),
                MyBrick(
                  brickX: myBricks[4][0],
                  brickY: myBricks[4][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[4][2],
                ),
                MyBrick(
                  brickX: myBricks[5][0],
                  brickY: myBricks[5][1],
                  brickWidth: brickWidth,
                  brickHeight: brickHeight,
                  brickBroken: myBricks[5][2],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
