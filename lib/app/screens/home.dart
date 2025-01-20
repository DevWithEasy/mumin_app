import 'package:flutter/material.dart';
import 'package:mumin/app/components/mumin/prayer_time_widget.dart';
import 'package:mumin/app/components/mumin/resticted_prayer_time_widget.dart';
import 'package:mumin/app/components/mumin/sahari_ifter_time_widget.dart';
import 'package:mumin/app/components/mumin/suntime_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
