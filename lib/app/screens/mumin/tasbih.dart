import 'package:flutter/material.dart';

class TasbihScreen extends StatelessWidget {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasbih Screen'),
      ),
      body: Center(
        child: Text('Selamat datang di Tasbih Screen'),
      ),
    );
  }
}