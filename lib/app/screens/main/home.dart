import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mumin/app/components/mainpage/prayer_time_widget.dart';
import 'package:mumin/app/components/mainpage/resticted_prayer_time_widget.dart';
import 'package:mumin/app/components/mainpage/sahari_ifter_time_widget.dart';
import 'package:mumin/app/components/mainpage/suntime_widget.dart';
import 'package:mumin/app/models/PrayerTimes.dart';
import 'package:mumin/app/providers/app_provider.dart';
import 'package:mumin/app/services/prayer_service.dart';
import 'package:mumin/app/services/shared_data.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PrayerTimes? prayerTimes;
  Future<void> checking() async {
    try {
      final local_data = await SharedData.getString('prayer_time');
      if (local_data != null) {
        final data = json.decode(local_data);
        setState(() {
          prayerTimes = PrayerTimes.fromJson(data);
        });
      }

      final fetchedPrayerTimes = await PrayerService.getPrayersTime();
      setState(() {
        prayerTimes = fetchedPrayerTimes;
      });

      bool? isAuto = SharedData.getBool('isAuto');
      String? city = SharedData.getString('city');
      String? country = SharedData.getString('country');

      final appProvider = Provider.of<AppProvider>(context, listen: false);
      appProvider.setIsAuto(isAuto ?? false);
      appProvider.setCity(city ?? 'Unknown');
      appProvider.setCountry(country ?? 'Unknown');
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: prayerTimes == null
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SunTime(prayerTimes: prayerTimes!),
                    SizedBox(height: 12),
                    PrayerTime(prayerTimes: prayerTimes!),
                    SizedBox(height: 12),
                    RestictedPrayerTime(prayerTimes: prayerTimes!),
                    SizedBox(height: 12),
                    SahariIfterTime(prayerTimes: prayerTimes!)
                  ],
                ),
        ),
      ),
    );
  }
}
