import 'package:flutter/material.dart';

class LevelBar extends StatelessWidget {
  final String text;
  final bool isActive;
  final tap;

  LevelBar({
    required this.text,
    this.isActive = false,
    this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.grey,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(1, 1),
                color: Color.fromARGB(255, 58, 57, 57),
              ),
            ]),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive
                  ? const Color.fromARGB(255, 77, 17, 13)
                  : const Color.fromARGB(255, 15, 58, 94),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
