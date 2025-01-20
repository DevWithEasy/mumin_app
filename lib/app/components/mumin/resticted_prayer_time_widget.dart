import 'package:flutter/material.dart';
import 'package:mumin/app/components/mumin/resticed_prayer_bottomsheet.dart';
import 'package:mumin/app/screens/faq.dart';

class RestictedPrayerTime extends StatelessWidget {
  const RestictedPrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135, // Set a fixed height or a height constraint
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 237, 255, 237),
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(
                    color: Color.fromARGB(255, 230, 252, 230), width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'সালাতের নিষিদ্ধ সময়',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.info),
                    ],
                  ),
                  SizedBox(height: 12),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'ভোরঃ',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '৬ঃ৪২ - ৬ঃ৫৭',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'ভোরঃ',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '৬ঃ৪২ - ৬ঃ৫৭',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'ভোরঃ',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '৬ঃ৪২ - ৬ঃ৫৭',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((context) {
                          return ResticedPrayerBottomsheet();
                        }));
                  },
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 237, 255, 237),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: Color.fromARGB(255, 230, 252, 230),
                            width: 2),
                      ),
                      child: Text('নফল নামাযের ওয়াক্ত'),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FaqScreen()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 237, 255, 237),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                            color: Color.fromARGB(255, 230, 252, 230),
                            width: 2),
                      ),
                      child: Text('বিশেষ দ্রষ্টব্য (FAQ)'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
