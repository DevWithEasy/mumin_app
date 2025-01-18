import 'package:flutter/material.dart';
import 'package:mumin/app/screens/mumin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progressValue = 0;

  @override
  void initState() {
    super.initState();
    startLoading();
  }

  void startLoading() {
    Future.delayed(const Duration(milliseconds: 10), () {
      if (progressValue < 100) {
        setState(() {
          progressValue += 1; 
        });
        startLoading();
      } else {
        navigateToNextScreen();
      }
    });
  }

  void navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MuminScreen()),
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
              const SizedBox(height: 10),
              Text(
                    "${progressValue.toInt()}%",
                    style: const TextStyle(fontSize: 12),
                  ),
              
            ],
          ),
        ),
      ),
    );
  }
}