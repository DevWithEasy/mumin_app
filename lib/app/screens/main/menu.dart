import 'package:flutter/material.dart';
import 'package:mumin/app/services/prayer_service.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: PrayerService.getCurrentLocation,
              child: Text("Get Location"),
            ),
          ],
        ),
      ),
    );
  }
}
