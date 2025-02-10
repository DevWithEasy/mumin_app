import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mumin/app/services/shared_data.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Future<void> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // 🛑 No network available, immediately print
      print("Device is not connected to the internet");
      return;
    }

    // ✅ Has network, now check actual internet access
    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(Duration(seconds: 2)); // Prevent long wait

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("Device is connected to the internet");
      } else {
        print("Device is not connected to the internet");
      }
    } catch (e) {
      print("Device is not connected to the internet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Location Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print(SharedData.getString('prayer_time'));
              },
              child: Text("Check"),
            ),
          ],
        ),
      ),
    );
  }
}
