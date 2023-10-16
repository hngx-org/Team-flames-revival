import 'dart:math';

enum Direction { UP, DOWN, LEFT, RIGHT }

class GameController {
  // Ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.01;
  double ballYIncrement = 0.01;
  double ballRadius = 0.02; // Represents 5% of the screen width
  Direction ballYDirection = Direction.DOWN;
  Direction ballXDirection = Direction.LEFT;

  // Player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  // Score and game state
  int score = 0;
  bool hasWon = false;
  bool isGamePaused = true;
  bool hasStartGame = false;
  bool isGameOver = false;
  int level = 1;

  // Bricks configuration (this could be adjusted as needed)
  // ... (your brick configurations, etc.)
   static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.01;
  static int numberOfBricksInRow = 4;
  static int numberOfRows = 4;
   static double wallGap = 0.5 * 
   (2 - numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * brickGap);
  static double firstBrickX = -1 + wallGap;
  static double firstBrickY = -0.9;
    static double getBrickY(int rowIndex) {
    return firstBrickY + rowIndex * (brickHeight + brickGap);
  }
  static double secondRowBrickY = firstBrickY + brickHeight + brickGap;

   List myBricks = List.generate(
    numberOfRows * numberOfBricksInRow,
    (i) => [
      firstBrickX + (i % numberOfBricksInRow) * (brickWidth + brickGap),
      getBrickY(i ~/ numberOfBricksInRow),
      false
    ],
  );
  GameController() {
    // Initial setup if necessary
  }


  
  //   void startGame() {
  //   // / Ensure any existing timer is canceled before starting a new one
  //   hasStartGame = true;
  //   if (gameTimer != null) {
  //     gameTimer!.cancel();
  //   }
  //   gameTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
  //     // Update direction
  //     updateDirection();

  //     // Move ball
  //     moveBall();

  //     // Check if player is dead
  //     if (isPlayerDead()) {
  //       timer.cancel();
  //       setState(() {
  //         isGameOver = true;
  //       });
  //     }

  //     // Check if brick is hit
  //     checkForBrokenBricks();

  //     if (allBricksBroken()) {
  //       setState(() {
  //         hasWon = true;
  //       });
  //     }

  //     // if (isGameWon()) {
  //     //   timer.cancel();
  //     //   setState(() {
  //     //     gameWon = true; // Set a flag indicating the game is won
  //     //     Navigator.of(context).pushNamed(LevelTwo.routeName);
  //     //   });
  //     // }
  //   });
  // }


  void pauseGame() {
    isGamePaused = true;
    // Logic for pausing the game
  }

  void resumeGame() {
    isGamePaused = false;
    // Logic for resuming the game
  }

  void moveLeft() {
    if (!(playerX - 0.2 < -1)) {
      playerX -= 0.2;
    }
  }

  void moveRight() {
    if (!(playerX + playerWidth >= 1)) {
      playerX += 0.2;
    }
  }

  void resetGame() {
    // Reset game variables
    isGameOver = false;
    hasStartGame = false;
    playerX = -0.2;
    ballY = 0;
    ballX = 0;
    score = 0;

    // Reset bricks to initial state (based on your logic)
  }

  bool checkAllBricksBroken() {
    return myBricks.every((brick) => brick[2] == true);
  }

  void updateDirection() {
    // ... your logic for updating direction
  }

  // ... any other methods related to game logic

  // Note: The timer and game loop logic might be better suited within the widget or a separate manager,
  // because they interact directly with the Flutter framework (e.g., setState).
}
