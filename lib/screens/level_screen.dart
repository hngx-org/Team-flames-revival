import 'package:breakout_revival/widgets/icon_bar.dart';
import 'package:breakout_revival/widgets/level_bar.dart';
import 'package:breakout_revival/widgets/overview_menu.dart';
import 'package:flutter/material.dart';

// Define the main widget for the app
class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  var isFirstScreen = true;

  void switchScreen() {
    setState(() {
      isFirstScreen = !isFirstScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        title: Opacity(
          opacity: 1,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.red, Colors.green, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'BRICKLE',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: const Color(0xFF000000),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: MediaQuery.of(context).size.height * 0.78,
                child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1 / 1,
                    crossAxisCount: 4,
                    children: [
                      LevelBar(
                        text: "1",
                        isActive: true,
                        tap: () {},
                      ),
                      LevelBar(
                        text: "2",
                        tap: () {},
                      ),
                      LevelBar(text: "3", tap: () {}),
                      LevelBar(text: "4", tap: () {}),
                      LevelBar(text: "5", tap: () {}),
                      LevelBar(text: "6", tap: () {}),
                      LevelBar(text: "7", tap: () {}),
                      LevelBar(text: "8", tap: () {}),
                      LevelBar(text: "9", tap: () {}),
                      LevelBar(text: "10", tap: () {}),
                      LevelBar(text: "11", tap: () {}),
                      LevelBar(text: "12", tap: () {}),
                      LevelBar(text: "13", tap: () {}),
                      LevelBar(text: "14", tap: () {}),
                      LevelBar(text: "15", tap: () {}),
                      LevelBar(text: "16", tap: () {}),
                    ]
                    // Map each power-up to a widget and display them in a grid
                    ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.75,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 53, 53),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconBar(
                  icon: Icons.shopping_cart,
                  color: Colors.red,
                  innerColor: Color.fromARGB(255, 24, 111, 27),
                ),
                IconBar(
                  icon: Icons.share,
                  color: Colors.green,
                  innerColor: Color.fromARGB(255, 101, 15, 116),
                ),
                IconBar(
                  icon: Icons.speaker,
                  color: Colors.blue,
                  innerColor: Colors.white,
                ),
                IconBar(
                  icon: Icons.align_vertical_bottom_outlined,
                  color: Colors.yellow,
                  innerColor: Color.fromARGB(255, 20, 99, 22),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
