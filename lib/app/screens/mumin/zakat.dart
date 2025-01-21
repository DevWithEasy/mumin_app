import 'package:flutter/material.dart';

class ZakatScreen extends StatelessWidget {
  const ZakatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zakat Calculator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Zakat Calculator'),
          ]))
    );
  }
}