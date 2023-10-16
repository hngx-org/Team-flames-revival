import 'package:breakout/homepage.dart';
import 'package:breakout/menu_screen.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 3000), () {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final primaryTextTheme = Theme.of(context).primaryTextTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Atari Breakout',
              style: primaryTextTheme.headlineMedium!.copyWith(
                color: Colors.deepPurple.shade500,
                fontWeight: FontWeight.w900,
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
