import 'package:breakout_revival/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      backgroundColor:  Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            RichText(
              text: TextSpan(
                style: primaryTextTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w900,
                ),
                children:  <TextSpan>[
                  const TextSpan(text: 'L',
                  style: TextStyle(color: Colors.green),
                  ),
                  const TextSpan(text: 'i',
                  style: TextStyle(color: Colors.red),
                  ),
                  const TextSpan(text: 'f',
                  style: TextStyle(color: Colors.yellow),
                  ),
                   TextSpan(text: 'e',
                  style: TextStyle(color: Colors.deepPurple[600]),
                  ),
                  
                  TextSpan(
                    text: ' is a Gift',
                    style: TextStyle(color: Colors.white, ),
                  ),
                ],
              ),
            ),
            

            const SizedBox(height: 20),
            const DashProgressIndicator(
              progress: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}

class DashProgressIndicator extends StatelessWidget {
  const DashProgressIndicator({
    super.key,
    required this.progress,
  });

  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 16,
        width: 200,
        child: ColoredBox(
          color: Colors.deepPurple.shade100,
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 3000),
                builder: (BuildContext context, double progress, _) {
                  return FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColoredBox(
                        color: Colors.deepPurple,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
