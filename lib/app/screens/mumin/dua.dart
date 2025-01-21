import 'package:flutter/material.dart';

class DuaScreen extends StatelessWidget {
  const DuaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dua Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Dua 1: "Selamat pagi, semoga hari ini lebih baik dan bersemangat dalam melaksanakan tugas-tugas yang ada."'),
            SizedBox(height: 16),
            Text('Dua 2: "Selamat sore, semoga hari ini lebih baik dan bersemangat dalam melaksanakan tugas-tugas yang ada."'),
          ],
        ),
      ),
    );
  }
}