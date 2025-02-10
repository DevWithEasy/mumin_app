  import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> checkInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // 🛑 No network available, immediately print
      print("Device is not connected to the internet");
      return;
    }

    // ✅ Has network, now check actual internet access
    try {
      final result = await InternetAddress.lookup('https://www.google.com')
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