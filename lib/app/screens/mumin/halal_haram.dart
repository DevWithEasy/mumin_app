import 'package:flutter/material.dart';

class HalamHaramScreen extends StatefulWidget {
  const HalamHaramScreen({super.key});

  @override
  State<HalamHaramScreen> createState() => _HalamHaramScreenState();
}

class _HalamHaramScreenState extends State<HalamHaramScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('হালাল হারাম')),
      body: Center(
        child: Text('Halal'),
      ),
    );
  }
}
