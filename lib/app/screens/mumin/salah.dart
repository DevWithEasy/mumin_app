import 'package:flutter/material.dart';

class SalahScreen extends StatelessWidget {
  const SalahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salah'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Salah'),
            Text('Jadwal Salah'),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Handle button click
                // Navigate to next screen or perform action
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
              },
              child: Text('Lihat Jadwal Salah'),
            ),
          ],
        ),
      ),
    );
  }
}