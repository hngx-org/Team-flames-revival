import 'dart:async';
import 'package:breakout/coverscreen.dart';
import 'package:breakout/game/components/ball.dart';
import 'package:breakout/game/components/brick.dart';
import 'package:breakout/gameoverscreen.dart';
import 'package:breakout/level_two.dart';
import 'package:breakout/player.dart';
import 'package:breakout/widgets/power_up.dart';
import 'package:flutter/material.dart';

enum Direction { UP, DOWN, LEFT, RIGHT }

enum powerUpType { EXPAND, FIREBALL }

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
  double ballRadius = 0.02; // Represents 5% of the screen width

  int score = 0;
  var ballYDirection = Direction.DOWN;
  var ballXDirection = Direction.LEFT;

  // Player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Bricks configuration
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 4;
  static int numberOfRows =
      4; // adjust this value for the number of rows you want
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
      false
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
          Navigator.of(context).pushNamed(LevelTwo.routeName);
        });
      }
    });
  }

  // void checkForBrokenBricks() {
  //   for (int i = 0; i < myBricks.length; i++) {
  //     if (!myBricks[i][2] &&
  //         ballX >= myBricks[i][0] &&
  //         ballX <= myBricks[i][0] + brickWidth &&
  //         ballY <= myBricks[i][1] + brickHeight &&
  //         ballY >= myBricks[i][1]) {
  //       setState(() {
  //         myBricks[i][2] = true;

  //         // Handle collision with bricks
  //         ballYDirection =
  //             ballYDirection == Direction.DOWN ? Direction.UP : Direction.DOWN;
  //       });
  //     }
  //   }
  // }

  var yVal;

  @override
  void initState() {
    // TODO: implement initState
    yVal = myBricks[1][1];
    super.initState();
  }

  void powerUpFall() {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        yVal += 0.004;
        if (yVal >= 0.9 && yVal >= playerX) {
          playerWidth = 0.6;
          timer.cancel();
        }
      });
    });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < myBricks.length; i++) {
      if (!myBricks[i][2] &&
          ballX + ballRadius >= myBricks[i][0] &&
          ballX - ballRadius <= myBricks[i][0] + brickWidth &&
          ballY + ballRadius >= myBricks[i][1] &&
          ballY - ballRadius <= myBricks[i][1] + brickHeight) {
        //run a quick check
        if (ballX + ballRadius >= myBricks[1][0] &&
            ballX - ballRadius <= myBricks[1][0] + brickWidth &&
            ballY + ballRadius >= myBricks[1][1] &&
            ballY - ballRadius <= myBricks[1][1] + brickHeight) {
          powerUpFall();
        }
        setState(() {
          //set brick to broken
          myBricks[i][2] = true;

          // Adjust ball's position based on its direction
          if (ballYDirection == Direction.DOWN) {
            ballY = myBricks[i][1] - ballRadius;
          } else {
            ballY = myBricks[i][1] + brickHeight + ballRadius;
          }

          // Reverse the ball's Y direction
          ballYDirection =
              ballYDirection == Direction.DOWN ? Direction.UP : Direction.DOWN;

          // Increase the score
          score += 10;
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

  // void resetGame() {
  //   print('reset game .>>>>>>>>');
  //   setState(() {
  //     isGameOver = false;
  //     hasStartGame = false;
  //     score = 0;
  //     playerX = -0.2;
  //     ballY = 0;
  //     ballX = 0;
  //     myBricks = List.generate(
  //       2 * numberOfBricksInRow,
  //       (i) => [
  //         firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
  //         i < numberOfBricksInRow ? firstBrickY : secondRowBrickY,
  //         false
  //       ],
  //     );
  //   });
  // }

  void resetGame() {
    setState(() {
      // Reset game variables
      isGameOver = false;
      hasStartGame = false;
      gameWon = false;
      playerX = -0.2;
      ballY = 0;
      ballX = 0;

      // Reset score to zero
      score = 0;

      // Reset bricks to initial state
      myBricks = List.generate(
        numberOfRows * numberOfBricksInRow,
        (i) => [
          firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
          getBrickY(i ~/ numberOfBricksInRow),
          false
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

                // Player
                MyPlayer(
                  playerX: playerX,
                  playerWidth: playerWidth,
                ),

                PowerUPs(
                  height: brickHeight,
                  width: brickWidth,
                  powerUpX: myBricks[1][0],
                  powerUpY: yVal,
                ),

                ...List.generate(
                  myBricks.length,
                  (i) => MyBrick(
                    brickX: myBricks[i][0],
                    brickY: myBricks[i][1],
                    brickWidth: brickWidth,
                    brickHeight: brickHeight,
                    brickBroken: myBricks[i][2],
                  ),
                ),

                // Score display
                Positioned(
                  top: 10,
                  right: 10,
                  child: Text(
                    'Score: $score',
                    style: const TextStyle(
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
