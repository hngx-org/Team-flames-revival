import 'package:flutter/material.dart';

Widget build3DButton(String label, {Function? onPressed}) {
  return SizedBox(
    width: 200,
    child: ElevatedButton(
      onPressed: onPressed as void Function()?,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: Colors.blueAccent.withOpacity(0.6),
            width: 2,
          ),
        ),
        elevation: 10,
        shadowColor: Colors.purpleAccent,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(4, 4),
              blurRadius: 5.0,
            ),
          ],
        ),
      ),
    ),
  );
}
