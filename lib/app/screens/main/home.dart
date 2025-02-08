import 'package:flutter/material.dart';
import 'package:mumin/app/components/mainpage/prayer_time_widget.dart';
import 'package:mumin/app/components/mainpage/resticted_prayer_time_widget.dart';
import 'package:mumin/app/components/mainpage/sahari_ifter_time_widget.dart';
import 'package:mumin/app/components/mainpage/suntime_widget.dart';
import 'package:mumin/app/services/prayer_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> checking() async {
    try {
      await PrayerService.getCurrentLocation();
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SunTime(),
            SizedBox(height: 12),
            PrayerTime(),
            SizedBox(height: 12),
            RestictedPrayerTime(),
            SizedBox(height: 12),
            SahariIfterTime()
          ],
        ),
      ),
    );
  }
}
