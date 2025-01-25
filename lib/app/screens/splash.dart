import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mumin/app/screens/main.dart';

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
    // Request storage permission
    var storageStatus = await Permission.storage.request();

    // Check if all permissions are granted
    if (locationStatus.isGranted && storageStatus.isGranted) {
      await saveLocationToSharedPreferences();
      navigateToNextScreen();
    } else if (locationStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied) {
      // Redirect user to app settings
      showSettingsDialog();
    } else {
      // If permissions are denied, retry
      showRetryDialog();
    }
  }

  Future<void> saveLocationToSharedPreferences() async {
    try {
      // Check if location services are enabled
      bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
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

      print("Location saved: Lat=${position.latitude}, Lon=${position.longitude}");
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
        title: const Text("Permission Required"),
        content: const Text(
            "Permissions for location and storage are required. Please enable them in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  void showRetryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Permission Denied"),
        content: const Text("Please allow location and storage permissions to proceed."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              requestPermissions(); // Retry permission request
            },
            child: const Text("Retry"),
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
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(), // Show loading indicator
            ],
          ),
        ),
      ),
    );
  }
}