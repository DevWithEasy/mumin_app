import 'package:flutter/material.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hadith App'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Hadith App!\n\nSelect a hadith to learn its meaning.',
        ),
      ),
    );
  }
}