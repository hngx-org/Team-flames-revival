import 'dart:async';
import 'dart:math';
import 'package:breakout/level_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ball.dart';
import 'brick.dart';
import 'coverscreen.dart';
import 'gameoverscreen.dart';
import 'player.dart';

enum Direction { UP, DOWN, LEFT, RIGHT }

class LevelTwo extends StatefulWidget {
  static const routeName = "level_two";
  LevelTwo();

  @override
  State<LevelTwo> createState() => _LevelTwoState();
}

class _LevelTwoState extends State<LevelTwo> {
  // Ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.02; // Increase ball speed
  double ballYIncrement = 0.02; // Increase ball speed
  double ballRadius = 0.02; // Represents 5% of the screen width

  int score = 0;
  var ballYDirection = Direction.DOWN;
  var ballXDirection = Direction.LEFT;

  // Player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Player variables
  double originalPlayerWidth = 0.4;

  // Bricks configuration
  static int numberOfBricksInRow = 6; // Increase the number of bricks in a row
  static int numberOfRows = 6; // Increase the number of rows
  static double brickWidth = 0.3;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
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

  // Power-up variables
  List<int> powerUpBrickIndices = [];
  late PowerUp powerUp;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  // void resetGame() {
  //   setState(() {
  //     // Reset game variables
  //     isGameOver = false;
  //     hasStartGame = false;
  //     playerX = -0.2;
  //     ballY = 0;
  //     ballX = 0;

  //     // Reset score to zero
  //     score = 0;

  //     // Generate random indices for power-up bricks
  //     powerUpBrickIndices.clear();
  //     while (powerUpBrickIndices.length < 3) {
  //       int randomIndex = Random().nextInt(myBricks.length);
  //       if (!powerUpBrickIndices.contains(randomIndex)) {
  //         powerUpBrickIndices.add(randomIndex);
  //         myBricks[randomIndex][2] = true; // Set the brick as a power-up brick
  //       }
  //     }

  //     // Reset the power-up
  //     powerUp = PowerUp(0, 0, 0.02, false);

  //     // Increase the number of bricks and rows for the new level
  //     numberOfBricksInRow = 6;
  //     numberOfRows = 6;

  //     // Reset bricks to the initial state for the new level
  //     myBricks = List.generate(
  //       numberOfRows * numberOfBricksInRow,
  //       (i) => [
  //         firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
  //         getBrickY(i ~/ numberOfBricksInRow),
  //         false
  //       ],
  //     );

  //     // Increase the ball speed for the new level
  //     ballXIncrement = 0.02;
  //     ballYIncrement = 0.02;
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

      // Reset player's size to its original value
      playerWidth = originalPlayerWidth;

      // Reset score to zero
      score = 0;

      // Increase the number of bricks and rows for the new level
      numberOfBricksInRow = 6;
      numberOfRows = 6;

      // Reset bricks to initial state for the new level
      myBricks = List.generate(
        numberOfRows * numberOfBricksInRow,
        (i) => [
          firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
          getBrickY(i ~/ numberOfBricksInRow),
          false
        ],
      );

      // Increase the ball speed for the new level
      ballXIncrement = 0.02;
      ballYIncrement = 0.02;
    });
  }

  bool isGameWon() {
    for (int i = 0; i < myBricks.length; i++) {
      if (!myBricks[i][2]) {
        return false; // There are still uncleared bricks
      }
    }
    return true; // All bricks are cleared
  }

  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  void startGame() {
    setState(() {
      hasStartGame = true;
    });

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

      // Check if the game is won
      if (isGameWon()) {
        timer.cancel();
        setState(() {
          gameWon = true;
          // You can navigate to the next level or show a victory screen here
          Navigator.of(context).pushNamed(LevelThree.routeName);
        });
      }
    });
  }

  void checkForBrokenBricks() {
    for (int i = 0; i < myBricks.length; i++) {
      if (!myBricks[i][2] &&
          ballX + ballRadius >= myBricks[i][0] &&
          ballX - ballRadius <= myBricks[i][0] + brickWidth &&
          ballY + ballRadius >= myBricks[i][1] &&
          ballY - ballRadius <= myBricks[i][1] + brickHeight) {
        setState(() {
          myBricks[i][2] = true;

          // Check if the brick is a power-up brick
          if (powerUpBrickIndices.contains(i)) {
            powerUp.active = true;
            powerUp.powerUpX = myBricks[i][0] + brickWidth / 2;
            powerUp.powerUpY = myBricks[i][1] + brickHeight / 2;
          }

          // Handle collision with bricks
          ballYDirection =
              ballYDirection == Direction.DOWN ? Direction.UP : Direction.DOWN;
        });
      }
    }
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

      // Check for power-up collision
      if (powerUp.active &&
          ballX + ballRadius >= powerUp.powerUpX - powerUp.powerUpRadius &&
          ballX - ballRadius <= powerUp.powerUpX + powerUp.powerUpRadius &&
          ballY + ballRadius >= powerUp.powerUpY - powerUp.powerUpRadius &&
          ballY - ballRadius <= powerUp.powerUpY + powerUp.powerUpRadius) {
        // Increase player's size
        playerWidth *= 2;
        powerUp.active = false; // Deactivate the power-up
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

                  if (powerUp.active)
                    PowerUpBox(
                      powerUpX: powerUp.powerUpX,
                      powerUpY: powerUp.powerUpY,
                      powerUpRadius: powerUp.powerUpRadius,
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
      ),
    );
  }
}

class PowerUpBox extends StatelessWidget {
  final double powerUpX;
  final double powerUpY;
  final double powerUpRadius;

  PowerUpBox({
    required this.powerUpX,
    required this.powerUpY,
    required this.powerUpRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: (powerUpX - powerUpRadius) * MediaQuery.of(context).size.width,
      top: (powerUpY - powerUpRadius) * MediaQuery.of(context).size.height,
      child: Container(
        width: 2 * powerUpRadius * MediaQuery.of(context).size.width,
        height: 2 * powerUpRadius * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class PowerUp {
  double powerUpX;
  double powerUpY;
  double powerUpRadius;
  bool active;

  PowerUp(this.powerUpX, this.powerUpY, this.powerUpRadius, this.active);
}
