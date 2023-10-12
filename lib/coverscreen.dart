import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({required this.tapToPlay});
  final bool tapToPlay;

  @override
  Widget build(BuildContext context) {
    return tapToPlay
        ? Container()
        : Container(
            alignment: Alignment(0, -0.2),
            child: Text(
              "Tap to play",
              style: TextStyle(color: Colors.deepPurple[400]),
            ),
          );
  }
}
