import 'package:flutter/material.dart';

class OverviewMenu extends StatelessWidget {
  final String image;
  final String text;
  const OverviewMenu({
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: const BorderRadius.all(
        Radius.circular(100),
      ),
      child: SizedBox(
        height: 10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 53, 124, 56), width: 5),
                ),
                child: Image.asset(
                  width: 100,
                  height: 100,
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
