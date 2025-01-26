import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mumin/app/screens/main.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    // Request location permission
    var locationStatus = await Permission.location.request();

    // Check if all permissions are granted
    if (locationStatus.isGranted) {
      await saveLocationToSharedPreferences();
    }

    // Request storage permission
    var storageStatus = await Permission.storage.request();

    if (storageStatus.isDenied) {
      // Redirect user to app settings
      showSettingsDialog();
    }
  }

  Future<void> saveLocationToSharedPreferences() async {
    try {
      // Check if location services are enabled
      bool isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (!isLocationServiceEnabled) {
        throw Exception("Location services are disabled.");
      }

      // Get user's current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Save latitude and longitude to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble("latitude", position.latitude);
      await prefs.setDouble("longitude", position.longitude);

      print(
          "Location saved: Lat=${position.latitude}, Lon=${position.longitude}");
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  void showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("অনুমতি প্রয়োজন"),
        content: const Text(
            "আপনার নামাযের সঠিক পেতে অবস্থান ও ডাটাবেজের ফাইল গুলো ম্যানেজ করার জন্য লোকেশন ও স্টোরেজের অনুমতি দিতে হবে।"),
        actions: [
          TextButton(
            onPressed: () async {
              // Request storage permission
              AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
              if (build.version.sdkInt >= 30) {
                var storageStatus = await Permission.manageExternalStorage.request();
                if (storageStatus.isGranted) {
                  navigateToNextScreen();
                }else{
                  openAppSettings();
                }
              } else {
                var storageStatus= await Permission.storage.request();
                if (storageStatus.isGranted) {
                  navigateToNextScreen();
                }else{
                  openAppSettings();
                }
              }
            },
            child: const Text("অনুমতি দিন"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.blue.shade100],
            center: Alignment.center,
            radius: 0.9,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/icon.png',
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'মুমিন',
                style: TextStyle(fontSize: 20),
              ), // Show loading indicator
            ],
          ),
        ),
      ),
    );
  }
}
