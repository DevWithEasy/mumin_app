import 'package:flutter/material.dart';
import 'package:mumin/app/components/mainpage/time_countdown_widget.dart';
import 'package:mumin/app/models/PrayerTimes.dart';

class PrayerTime extends StatelessWidget {
  final PrayerTimes prayerTimes;
  const PrayerTime({super.key, required this.prayerTimes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 237, 255, 237),
          border: Border.all(
              width: 1.5, color: const Color.fromARGB(255, 213, 248, 213))),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text('এশার নামযের',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('ওয়াক্ত শেষ হতে বাকি',
                      style: TextStyle(color: Colors.grey)),
                  CountdownTimer(
                    endTime: '07:01',
                    height: 100,
                    width: 100,
                    fontSize: 14,
                  )
                ],
              )),
          Expanded(
            flex: 1,
            child: Column(
              children: prayerTimes.waktTimes().map((wakt){
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(wakt['name']!),
                          Text(wakt['time']!),
                        ],
                      ),
                    ),
                    Divider(height: 0.5),
                  ],
                );
              }).toList()
            ),
          )
        ],
      ),
    );
  }
}
