import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Text('Option 1'),
            Text('Option 2'),
            Text('Option 3'),
            Text('Option 4'),
            Text('Option 5'),
          ],
        ),
      ),
    );
  }
}