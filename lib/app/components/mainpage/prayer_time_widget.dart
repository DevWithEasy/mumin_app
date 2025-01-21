import 'package:flutter/material.dart';
import 'package:mumin/app/components/mainpage/time_countdown_widget.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 237, 255, 237),
        border: Border.all(width: 1.5,color: const Color.fromARGB(255, 213, 248, 213))
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text('এশার নামযের',style: TextStyle(fontWeight: FontWeight.bold)),
                Text('ওয়াক্ত শেষ হতে বাকি',style: TextStyle(color: Colors.grey)),
                CountdownTimer(
                  startTime: '07:00',
                  endTime: '07:01',
                  height: 100,
                  width : 100,
                  fontSize: 14,
                )
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3,bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('ফজর'),
                      Text('০৫ঃ১০ - ১০ঃ১১')
                    ],
                  ),
                ),
                Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.only(top: 3,bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('যোহর'),
                      Text('০৫ঃ১০ - ১০ঃ১১')
                    ],
                  ),
                ),
                Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.only(top: 3,bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('আসর'),
                      Text('০৫ঃ১০ - ১০ঃ১১')
                    ],
                  ),
                ),
                Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.only(top: 3,bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('মাগরিব'),
                      Text('০৫ঃ১০ - ১০ঃ১১')
                    ],
                  ),
                ),
                Divider(height: 0.5),
                Padding(
                  padding: const EdgeInsets.only(top: 3,bottom: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('এশা'),
                      Text('০৫ঃ১০ - ১০ঃ১১')
                    ],
                  ),
                ),
                Divider(height: 0.5),
              ],
            ),
          )
        ],
      ),
    );
  }
}