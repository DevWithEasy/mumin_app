import 'package:flutter/material.dart';
import 'package:mumin/app/components/mainpage/resticed_prayer_bottomsheet.dart';

class RestictedPrayerTime extends StatelessWidget {
  const RestictedPrayerTime({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Enables fullscreen behavior
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 1,
            expand: false,
            builder: (context, scrollController) => SingleChildScrollView(
              controller: scrollController,
              child: ResticedPrayerBottomsheet(),
            ),
          ),
        );
      },
      child: Container(
        height: 135,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 237, 255, 237),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border:
              Border.all(color: Color.fromARGB(255, 230, 252, 230), width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'সালাতের নিষিদ্ধ সময়',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'ভোরঃ',
                          ),
                          SizedBox(width: 8),
                          Text(
                            '৬ঃ৪২ - ৬ঃ৫৭',
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'ভোরঃ',
                          ),
                          SizedBox(width: 8),
                          Text(
                            '৬ঃ৪২ - ৬ঃ৫৭',
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'ভোরঃ',
                          ),
                          SizedBox(width: 8),
                          Text(
                            '৬ঃ৪২ - ৬ঃ৫৭',
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Image.asset('assets/images/home/mosque.png'),
            ),
          ],
        ),
      ),
    );
  }
}
