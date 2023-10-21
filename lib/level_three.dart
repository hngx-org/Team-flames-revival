import 'dart:async';
import 'package:breakout/coverscreen.dart';
import 'package:breakout/game/components/ball.dart';
import 'package:breakout/game/components/brick.dart';
import 'package:breakout/gameoverscreen.dart';
import 'package:breakout/player.dart';
import 'package:flutter/material.dart';

enum Direction { UP, DOWN, LEFT, RIGHT }

class LevelThree extends StatefulWidget {
  static const routeName = "level_three";
  LevelThree();

  @override
  State<LevelThree> createState() => _LevelThreeState();
}

class _LevelThreeState extends State<LevelThree> {
  // Ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.01;
  double ballYIncrement = 0.01;
  double ballRadius = 0.02; // Represents 5% of the screen width

  double ballX2 = 0; // Second ball
  double ballY2 = 0;
  double ballXIncrement2 =
      0.015; // You can adjust the speed for the second ball
  double ballYIncrement2 = 0.015;
  double ballRadius2 = 0.02; // Radius for the second ball

  int score = 0;
  int score2 = 0; // Score for the second ball

  var ballYDirection = Direction.DOWN;
  var ballXDirection = Direction.LEFT;

  var ballYDirection2 = Direction.DOWN; // Direction for the second ball
  var ballXDirection2 = Direction.RIGHT; // Set the initial direction

  // Player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Bricks configuration
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 4;
  static int numberOfRows =
      4; // Adjust this value for the number of rows you want
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);

  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
  static double secondRowBrickY = firstBrickY + brickHeight + brickGap;

  static double getBrickY(int rowIndex) {
    return firstBrickY + rowIndex * (brickHeight + brickGap);
  }

  List myBricks = List.generate(
    numberOfRows * numberOfBricksInRow,
    (i) => [
      firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
      getBrickY(i ~/ numberOfBricksInRow),
      false,
    ],
  );

  // Game state variables
  bool hasStartGame = false;
  bool isGameOver = false;
  bool gameWon = false;

  bool isGameWon() {
    for (int i = 0; i < myBricks.length; i++) {
      if (!myBricks[i][2]) {
        return false; // There are still uncleared bricks
      }
    }
    return true; // All bricks are cleared
  }

  // Game logic methods
  void startGame() {
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      // Update direction
      updateDirection();

      // Move ball
      moveBall();

      // Check if player is dead
      if (isPlayerDead()) {
        timer.cancel();
        setState(() {
          isGameOver = true;
        });
      }

      // Check if brick is hit
      checkForBrokenBricks();

      if (isGameWon()) {
        timer.cancel();
        setState(() {
          gameWon = true; // Set a flag indicating the game is won
          // Navigator.of(context).pushNamed(LevelTwo.routeName);
        });
      }
    });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < myBricks.length; i++) {
      if (!myBricks[i][2]) {
        if (isCollision(ballX, ballY, ballRadius, myBricks[i])) {
          setState(() {
            myBricks[i][2] = true;
            // Handle collision with bricks
            ballYDirection = (ballYDirection == Direction.DOWN)
                ? Direction.UP
                : Direction.DOWN;
            score += 10;
          });
        }
        if (isCollision(ballX2, ballY2, ballRadius2, myBricks[i])) {
          setState(() {
            myBricks[i][2] = true;
            // Handle collision with bricks for the second ball
            ballYDirection2 = (ballYDirection2 == Direction.DOWN)
                ? Direction.UP
                : Direction.DOWN;
            score2 += 10;
          });
        }
      }
    }
  }

  bool isCollision(double ballX, double ballY, double ballRadius, List brick) {
    double brickX = brick[0];
    double brickY = brick[1];
    bool isBroken = brick[2];

    if (!isBroken) {
      double distX = (ballX - brickX).abs();
      double distY = (ballY - brickY).abs();

      if (distX > (brickWidth / 2 + ballRadius)) return false;
      if (distY > (brickHeight / 2 + ballRadius)) return false;

      if (distX <= brickWidth / 2) return true;
      if (distY <= brickHeight / 2) return true;

      double dx = distX - brickWidth / 2;
      double dy = distY - brickHeight / 2;
      return dx * dx + dy * dy <= (ballRadius * ballRadius);
    }
    return false;
  }

  // bool isPlayerDead() {
  //   if (ballY >= 1) {
  //     return true;
  //   }
  //   return false;
  // }

  bool isPlayerDead() {
    if (ballY >= 1 || ballY2 >= 1) {
      return true;
    }
    return false;
  }

  void moveBall() {
    setState(() {
      if (ballXDirection == Direction.LEFT) {
        ballX -= ballXIncrement;
      } else if (ballXDirection == Direction.RIGHT) {
        ballX += ballXIncrement;
      }
      if (ballYDirection == Direction.DOWN) {
        ballY += ballYIncrement;
      } else if (ballYDirection == Direction.UP) {
        ballY -= ballYIncrement;
      }

      // Move the second ball
      if (ballXDirection2 == Direction.LEFT) {
        ballX2 -= ballXIncrement2;
      } else if (ballXDirection2 == Direction.RIGHT) {
        ballX2 += ballXIncrement2;
      }
      if (ballYDirection2 == Direction.DOWN) {
        ballY2 += ballYIncrement2;
      } else if (ballYDirection2 == Direction.UP) {
        ballY2 -= ballYIncrement2;
      }
    });
  }

  void updateDirection() {
    setState(() {
      if (ballX <= -1) {
        ballXDirection = Direction.RIGHT;
      } else if (ballX >= 1) {
        ballXDirection = Direction.LEFT;
      }
      if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = Direction.UP;
      } else if (ballY <= -1) {
        ballYDirection = Direction.DOWN;
      }

      // Update direction for the second ball
      if (ballX2 <= -1) {
        ballXDirection2 = Direction.RIGHT;
      } else if (ballX2 >= 1) {
        ballXDirection2 = Direction.LEFT;
      }
      if (ballY2 >= 0.9 &&
          ballX2 >= playerX &&
          ballX2 <= playerX + playerWidth) {
        ballYDirection2 = Direction.UP;
      } else if (ballY2 <= -1) {
        ballYDirection2 = Direction.DOWN;
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
      ballY2 = 0; // Reset the second ball
      ballX2 = 0;
      score = 0;
      score2 = 0; // Reset the second ball's score
      myBricks = List.generate(
        numberOfRows * numberOfBricksInRow,
        (i) => [
          firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
          getBrickY(i ~/ numberOfBricksInRow),
          false,
        ],
      );
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
                  ballRadius: ballRadius,
                ),

                // Second Ball
                MyBall(
                  ballX: ballX2,
                  ballY: ballY2,
                  ballRadius: ballRadius2,
                ),

                // Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                ...List.generate(
                  myBricks.length,
                  (i) => MyBrick(
                    brickX: myBricks[i][0],
                    brickY: myBricks[i][1],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                    brickBroken: myBricks[i][2],
                    color:  Colors.deepPurple,
                  ),
                ),

                // Score display
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text(
                    'Score: $score',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Score display for the second ball
                Positioned(
                  top: 10,
                  left: 10,
                  child: Text(
                    'Score 2: $score2',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
