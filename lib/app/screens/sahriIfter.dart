import 'package:flutter/material.dart';
import 'package:mumin/app/components/mainpage/time_countdown_widget.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class SahriifterScreen extends StatelessWidget {
  final String sahri;
  final String ifter;
  const SahriifterScreen({super.key, required this.sahri, required this.ifter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('সাহরি ও ইফতারের সময়'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 237, 255, 237),
                      border: Border.all(
                          width: 1.5,
                          color: const Color.fromARGB(255, 213, 248, 213))),
                  child: Column(children: [
                    SizedBox(height: 12),
                    Text('ইফতারের বাকি',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    CountdownTimer(
                      endTime: ifter,
                      height: 150,
                      width: 150,
                      fontSize: 20,
                    ),
                    SizedBox(height: 14),
                    Text(
                        'মানুষের পরিবার, ধন-সম্পদ ও প্রতিবেশীর ব্যাপারে ঘটিত বিভিন্ন ফেতনা ও গুনাহর কাফফারা হলো নামাজ, রোজা ও সদকা।',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 5),
                    Text('(বুখারি, হাদিস: ১৮৯৫)',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 14)
                  ])),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color.fromARGB(255, 237, 255, 237),
                    border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 213, 248, 213))),
                child: Row(
                  children: [
                    // First Column
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:  [
                            Text(convertToBanglaNumbers(sahri), style: TextStyle(fontSize: 20)),
                            SizedBox(height: 5),
                            Text('সাহরির শেষ'),
                            SizedBox(height: 16),
                            Text('এলার্ম',
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 100,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(convertToBanglaNumbers(ifter), style: TextStyle(fontSize: 20)),
                            SizedBox(height: 5),
                            Text('ইফতারের শুরু'),
                            SizedBox(height: 16),
                            Text('এলার্ম',
                                style: TextStyle(color: Colors.green)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
