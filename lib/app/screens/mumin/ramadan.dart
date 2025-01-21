import 'package:flutter/material.dart';

class RamadanScreen extends StatelessWidget {
  const RamadanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ramadan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ramadan 2023'),
          ]
        ))
    );
  }
}