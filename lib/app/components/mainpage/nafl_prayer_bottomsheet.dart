import 'package:flutter/material.dart';

class NaflPrayerBottomsheet extends StatelessWidget {
  const NaflPrayerBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'নফল সালাতের ওয়াক্ত',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'This is a bottom sheet. You can place any content here.',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pop(context); // Close the bottom sheet
          //   },
          //   child: Text('Close'),
          // ),
        ],
      ),
    );
  }
}
