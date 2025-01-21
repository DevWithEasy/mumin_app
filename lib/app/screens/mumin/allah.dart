import 'package:flutter/material.dart';

class AllahScreen extends StatelessWidget {
  const AllahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Allah'),
      ),
      body: Center(
        child: Text(
          'Welcome to Allah App',
        ),
      ),
    );
  }
}