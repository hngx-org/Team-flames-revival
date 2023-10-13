// import 'package:flutter/material.dart';

// class MyBrick extends StatelessWidget {
//   final brickWidth;
//   final brickHeight;
//   final brickX;
//   final brickY;
//   final brickBroken;
//   const MyBrick({
//     required this.brickWidth,
//     required this.brickHeight,
//     required this.brickX,
//     required this.brickY,
//     required this.brickBroken,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment((2 * brickX + brickWidth)/ (2 - brickWidth), brickY),
//       child: brickBroken
//           ? Container()
//           : ClipRRect(
//               borderRadius: BorderRadius.circular(5),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * brickHeight / 2,
//                 width: MediaQuery.of(context).size.width * brickWidth / 2,
//                 color: Colors.deepPurple,
//               ),
//             ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  final double brickWidth;
  final double brickHeight;
  final double brickX;
  final double brickY;
  final bool brickBroken;

  const MyBrick({
    required this.brickWidth,
    required this.brickHeight,
    required this.brickX,
    required this.brickY,
    required this.brickBroken,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the actual height and width of the brick based on the screen dimensions
    double actualWidth = MediaQuery.of(context).size.width * (brickWidth / 2);
    double actualHeight =
        MediaQuery.of(context).size.height * (brickHeight / 2);

    return Positioned(
      left: MediaQuery.of(context).size.width * (brickX + 1) / 2,
      top: MediaQuery.of(context).size.height * (brickY + 1) / 2,
      child: brickBroken
          ? Container()
          : ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: actualHeight,
                width: actualWidth,
                color: Colors.deepPurple,
              ),
            ),
    );
  }
}
