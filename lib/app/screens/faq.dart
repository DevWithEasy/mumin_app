import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Question 1'),
            Text('Answer 1'),
            Text('Question 2'),
            Text('Answer 2'),
            Text('Question 3'),
            Text('Answer 3'),
          ],
        ),
      ),
    );
  }
}