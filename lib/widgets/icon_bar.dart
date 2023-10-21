import 'package:flutter/material.dart';

class IconBar extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color innerColor;
  const IconBar({
    required this.icon,
    required this.color,
    required this.innerColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 58, 57, 57),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Icon(
            icon,
            color: innerColor,
          ),
        ),
      ),
    );
  }
}
