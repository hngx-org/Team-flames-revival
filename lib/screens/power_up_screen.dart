import 'package:breakout_revival/widgets/icon_bar.dart';
import 'package:flutter/material.dart';

// Define a custom class for each power-up
class PowerUp {
  final String name;
  final IconData icon;
  final Color color;

  PowerUp(this.name, this.icon, this.color);
}

// Define a list of power-ups
List<PowerUp> powerUps = [
  PowerUp('Expand', Icons.expand, Colors.red),
  PowerUp('Fire Ball', Icons.fireplace, Colors.orange),
  PowerUp('Extra Life', Icons.favorite, Colors.pink),
  PowerUp('Level Magnet', Icons.home, Colors.blue),
  PowerUp('Ball Warp', Icons.sync, Colors.purple),
  PowerUp('Shooting Paddle', Icons.shield, Colors.green),
  PowerUp('Slow Ball', Icons.slow_motion_video, Colors.cyan),
  PowerUp('Explode Bricks', Icons.bolt, Colors.yellow),
  PowerUp('Match Factory', Icons.production_quantity_limits, Colors.brown),
  PowerUp('Split Ball', Icons.horizontal_split, Colors.red),
  PowerUp('Ice Ball', Icons.ac_unit, Colors.blue),
  PowerUp('Thru Ball', Icons.arrow_right_alt, Colors.green),
  PowerUp('Fast Bricks', Icons.speed, Colors.orange),
  PowerUp('Ghost Ball', Icons.visibility_off, Colors.purple),
  PowerUp('Death Ball', Icons.warning, Colors.red),
  PowerUp('Shrink Ball', Icons.compress, Colors.cyan),
  PowerUp('Install', Icons.download, Colors.grey),
];

// Define a custom widget for each power-up item
class PowerUpItem extends StatelessWidget {
  final PowerUp powerUp;

  const PowerUpItem({Key? key, required this.powerUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                elevation: 10,
                icon: Icon(
                  powerUp.icon,
                  size: 48.0,
                  color: powerUp.color,
                ),
                title: Text(powerUp.name),
                content: const Text("Content Here"),
                backgroundColor: Color.fromARGB(255, 85, 82, 82),
              );
            });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(powerUp.icon, size: 48.0, color: powerUp.color),
            Text(powerUp.name,
                style: TextStyle(color: powerUp.color, fontSize: 16.0)),
          ],
        ),
      ),
    );
  }
}

// Define the main widget for the app
class PowerUpScreen extends StatefulWidget {
  const PowerUpScreen({super.key});

  @override
  State<PowerUpScreen> createState() => _PowerUpScreenState();
}

class _PowerUpScreenState extends State<PowerUpScreen> {
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
            child: Text(
              isFirstScreen ? 'Atari' : 'PowerUps',
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
              isFirstScreen
                  ? Text("Hello")
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.78,
                      child: GridView.count(
                        childAspectRatio: 2 / 1,
                        crossAxisCount: 2,
                        children: powerUps
                            .map((powerUp) => PowerUpItem(powerUp: powerUp))
                            .toList(), // Map each power-up to a widget and display them in a grid
                      ),
                    ),
              Align(
                alignment: isFirstScreen
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: IconButton(
                  color: Colors.red,
                  splashColor: const Color.fromARGB(255, 243, 142, 134),
                  splashRadius: 50,
                  onPressed: () {
                    switchScreen();
                  },
                  icon: isFirstScreen
                      ? Icon(Icons.arrow_forward_ios)
                      : Icon(Icons.arrow_back_ios),
                ),
              )
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
