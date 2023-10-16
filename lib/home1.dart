// import 'dart:async';
// import 'dart:math';
// import 'package:breakout/game/components/ball.dart';
// import 'package:breakout/game/components/brick.dart';
// import 'package:breakout/coverscreen.dart';
// import 'package:breakout/gameoverscreen.dart';
// import 'package:breakout/level_two.dart';
// import 'package:breakout/player.dart';
// import 'package:confetti/confetti.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:google_fonts/google_fonts.dart';

// enum Direction { UP, DOWN, LEFT, RIGHT }

// class HomePage extends StatefulWidget {
//   HomePage();

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   // Bricks configuration
//   // static double brickWidth = 0.4;
//   // static double brickHeight = 0.05;
//   // static double brickGap = 0.01;
//   // static int numberOfBricksInRow = 4;
//   // static int numberOfRows =
//   //     4; // adjust this value for the number of rows you want
//   // static double wallGap = 0.5 *
//   //     (2 -
//   //         numberOfBricksInRow * brickWidth -
//   //         (numberOfBricksInRow - 1) * brickGap);

//   // static double firstBrickX = -1 + wallGap;
//   // static double firstBrickY = -0.9;
//   bool hasWon = false;
//   bool isGamePaused = true;

//   ConfettiController _controllerCenter =
//       ConfettiController(duration: Duration(seconds: 2));
//   ConfettiController _controllerLeft =
//       ConfettiController(duration: Duration(seconds: 2));
//   ConfettiController _controllerRight =
//       ConfettiController(duration: Duration(seconds: 2));
//   int level = 1; // Initialize the game at level 1
//   Timer? gameTimer; // This will hold our game loop timer

//   // static double getBrickY(int rowIndex) {
//   //   return firstBrickY + rowIndex * (brickHeight + brickGap);
//   // }

//   // List myBricks = List.generate(
//   //   numberOfRows * numberOfBricksInRow,
//   //   (i) => [
//   //     firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
//   //     getBrickY(i ~/ numberOfBricksInRow),
//   //     false
//   //   ],
//   // );

//   // Game state variables
//   bool hasStartGame = false;
//   bool isGameOver = false;
//   bool gameWon = false;

//   bool isGameWon() {
//     for (int i = 0; i < myBricks.length; i++) {
//       if (!myBricks[i][2]) {
//         return false; // There are still uncleared bricks
//       }
//     }
//     return true; // All bricks are cleared
//   }

//   // Game logic methods
//   // void startGame() {
//   //   // / Ensure any existing timer is canceled before starting a new one
//   //   hasStartGame = true;
//   //   if (gameTimer != null) {
//   //     gameTimer!.cancel();
//   //   }
//   //   gameTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
//   //     // Update direction
//   //     updateDirection();

//   //     // Move ball
//   //     moveBall();

//   //     // Check if player is dead
//   //     if (isPlayerDead()) {
//   //       timer.cancel();
//   //       setState(() {
//   //         isGameOver = true;
//   //       });
//   //     }

//   //     // Check if brick is hit
//   //     checkForBrokenBricks();

//   //     if (allBricksBroken()) {
//   //       setState(() {
//   //         hasWon = true;
//   //       });
//   //     }

//   //     // if (isGameWon()) {
//   //     //   timer.cancel();
//   //     //   setState(() {
//   //     //     gameWon = true; // Set a flag indicating the game is won
//   //     //     Navigator.of(context).pushNamed(LevelTwo.routeName);
//   //     //   });
//   //     // }
//   //   });
//   // }

//   bool allBricksBroken() {
//     for (var brick in myBricks) {
//       if (brick[2] == false) {
//         // If the brick is not broken
//         return false;
//       }
//     }
//     return true; // All bricks are broken
//   }

//   void checkForBrokenBricks() {
//     for (int i = 0; i < myBricks.length; i++) {
//       if (!myBricks[i][2] &&
//           ballX + ballRadius >= myBricks[i][0] &&
//           ballX - ballRadius <= myBricks[i][0] + brickWidth &&
//           ballY + ballRadius >= myBricks[i][1] &&
//           ballY - ballRadius <= myBricks[i][1] + brickHeight) {
//         setState(() {
//           myBricks[i][2] = true;

//           // Adjust ball's position based on its direction
//           if (ballYDirection == Direction.DOWN) {
//             ballY = myBricks[i][1] - ballRadius;
//           } else {
//             ballY = myBricks[i][1] + brickHeight + ballRadius;
//           }

//           // Reverse the ball's Y direction
//           ballYDirection =
//               ballYDirection == Direction.DOWN ? Direction.UP : Direction.DOWN;

//           // Increase the score
//           score += 2;
//         });

//         if (checkAllBricksBroken()) {
//           _controllerCenter.play();
//           _controllerLeft.play();
//           _controllerRight.play();

//           showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               elevation: 10,
//               backgroundColor: const Color.fromARGB(255, 25, 7, 73),
//               title: Center(
//                 child: Text(
//                   "Congratulations!",
//                   style: GoogleFonts.yujiSyuku(
//                     color: const Color.fromARGB(255, 211, 128, 155),
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               content: Text(
//                 "You have cleared all bricks! Ready for the next level?",
//                 style: GoogleFonts.biryani(
//                   color: Colors.white,
//                   fontSize: 15,
//                 ),
//               ),
//               actions: [
//                 Center(
//                   child: SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       child: Text("Next Level"),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                             Color.fromARGB(255, 130, 149, 158)),
//                       ),
//                       onPressed: () {
//                         // Logic for moving to the next level
//                         level++;

//                         Navigator.pop(context);
//                         Navigator.of(context).pushReplacement(MaterialPageRoute(
//                             builder: (context) =>
//                                 LevelTwo())); // Resetting the game for now, you can replace this with logic for the next level
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );

//           ; // Increase level by 1
//         }
//       }
//     }
//   }

//   void pauseGame() {
//     if (gameTimer != null) {
//       gameTimer!.cancel();
//     }
//     setState(() {
//       isGamePaused = true;
//     });
//   }

//   void resumeGame() {
//     startGame();
//     setState(() {
//       isGamePaused = false;
//     });
//   }

//   String findMin(double a, double b, double c, double d) {
//     List<double> myList = [a, b, c, d];
//     double currentMin = a;
//     for (int i = 0; i < myList.length; i++) {
//       if (myList[i] < currentMin) {
//         currentMin = myList[i];
//       }
//     }
//     if ((currentMin - a).abs() < 0.01) {
//       return 'left';
//     } else if ((currentMin - b).abs() < 0.01) {
//       return 'right';
//     } else if ((currentMin - c).abs() < 0.01) {
//       return 'top';
//     } else if ((currentMin - d).abs() < 0.01) {
//       return 'bottom';
//     }

//     return '';
//   }

//   bool isPlayerDead() {
//     if (ballY >= 1) {
//       return true;
//     }
//     return false;
//   }

//   void moveBall() {
//     setState(() {
//       if (ballXDirection == Direction.LEFT) {
//         ballX -= ballXIncrement;
//       } else if (ballXDirection == Direction.RIGHT) {
//         ballX += ballXIncrement;
//       }
//       if (ballYDirection == Direction.DOWN) {
//         ballY += ballYIncrement;
//       } else if (ballYDirection == Direction.UP) {
//         ballY -= ballYIncrement;
//       }
//     });
//   }

//   void updateDirection() {
//     setState(() {
//       if (ballX <= -1) {
//         ballXDirection = Direction.RIGHT;
//       } else if (ballX >= 1) {
//         ballXDirection = Direction.LEFT;
//       }
//       if (ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth) {
//         ballYDirection = Direction.UP;
//       } else if (ballY <= -1) {
//         ballYDirection = Direction.DOWN;
//       }
//     });
//   }

//   void moveLeft() {
//     setState(() {
//       if (!(playerX - 0.2 < -1)) {
//         playerX -= 0.2;
//       }
//     });
//   }

//   void moveRight() {
//     setState(() {
//       if (!(playerX + playerWidth >= 1)) {
//         playerX += 0.2;
//       }
//     });
//   }

//   void resetGame() {
//     setState(() {
//       // Reset game variables
//       isGameOver = false;
//       hasStartGame = false;
//       gameWon = false;
//       playerX = -0.2;
//       ballY = 0;
//       ballX = 0;

//       // Reset score to zero
//       score = 0;

//       // Reset bricks to initial state
//       myBricks = List.generate(
//         numberOfRows * numberOfBricksInRow,
//         (i) => [
//           firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
//           getBrickY(i ~/ numberOfBricksInRow),
//           false
//         ],
//       );
//     });
//   }

//   checkAllBricksBroken() {
//     print('Checking all bricks broken>>>>>>>>>>>>>>>>>>>>>');
//     bool allBroken = myBricks.every((brick) => brick[2] == true);
//     if (allBroken) {
//       print('All bricks broken>>>>>>>>>>>>>>>>>>>>>');
//       return true;
//     } else {
//       return false;
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     _controllerCenter = ConfettiController(duration: Duration(seconds: 2));
//     _controllerLeft = ConfettiController(duration: Duration(seconds: 2));
//     _controllerRight = ConfettiController(duration: Duration(seconds: 2));
//     SchedulerBinding.instance.addPostFrameCallback((_) {});
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _controllerCenter.dispose();
//     _controllerLeft.dispose();
//     _controllerRight.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => startGame(),
//       onHorizontalDragUpdate: (details) {
//         if (details.delta.dx < 0) {
//           moveLeft();
//         } else if (details.delta.dx > 0) {
//           moveRight();
//         }
//       },
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: Colors.deepPurple[100],
//           body: Center(
//             child: Stack(
//               children: [
//                 // Background elements

//                 Positioned(
//                   top: 10,
//                   left: 10,
//                   child: Text(
//                     "Level: $level",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),

//                 // Pause button
//                 Positioned(
//                   top: 10,
//                   right: 100,
//                   child: InkWell(
//                     onTap:
//                         hasStartGame && !isGamePaused ? pauseGame : resumeGame,
//                     child: Icon(
//                       (!hasStartGame || isGamePaused)
//                           ? Icons.play_arrow
//                           : Icons.pause,
//                     ),
//                   ),
//                 ),

//                 // Tap to play
//                 CoverScreen(
//                   tapToPlay: hasStartGame,
//                   isGameOver: isGameOver,
//                   hasGameStarted: hasStartGame,
//                 ),

//                 // Game over screen
//                 GameOverScreen(
//                   isGameOver: isGameOver,
//                   function: () {
//                     resetGame();
//                   },
//                 ),

//                 // Ball
//                 MyBall(
//                   ballX: ballX,
//                   ballY: ballY,
//                   ballRadius: ballRadius,
//                 ),

//                 // Player
//                 MyPlayer(
//                   playerX: playerX,
//                   playerWidth: playerWidth,
//                 ),

//                 ...List.generate(
//                   myBricks.length,
//                   (i) => MyBrick(
//                     brickX: myBricks[i][0],
//                     brickY: myBricks[i][1],
//                     brickWidth: brickWidth,
//                     brickHeight: brickHeight,
//                     brickBroken: myBricks[i][2],
//                   ),
//                 ),

//                 // The confetti views
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: ConfettiWidget(
//                     confettiController: _controllerCenter,
//                     blastDirection: pi / 2,
//                     maxBlastForce: 5,
//                     minBlastForce: 2,
//                     emissionFrequency: 0.05,
//                     numberOfParticles: 20,
//                     gravity: 1,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: ConfettiWidget(
//                     confettiController: _controllerLeft,
//                     blastDirection: pi / 3,
//                     maxBlastForce: 5,
//                     minBlastForce: 2,
//                     emissionFrequency: 0.05,
//                     numberOfParticles: 10,
//                     gravity: 1,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: ConfettiWidget(
//                     confettiController: _controllerRight,
//                     blastDirection: 2 * pi / 3,
//                     maxBlastForce: 5,
//                     minBlastForce: 2,
//                     emissionFrequency: 0.05,
//                     numberOfParticles: 10,
//                     gravity: 1,
//                   ),
//                 ),

//                 // Score display
//                 Positioned(
//                   top: 10,
//                   right: 10,
//                   child: Text(
//                     'Score: $score',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
