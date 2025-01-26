import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
            TextButton(
              onPressed: () async {
                var str = await Permission.storage.status;
                print(str);
              },
              child: Text('Check'),
            )
          ],
        ),
      ),
    );
  }
}
