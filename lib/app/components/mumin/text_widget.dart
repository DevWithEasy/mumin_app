import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello, Flutter!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
