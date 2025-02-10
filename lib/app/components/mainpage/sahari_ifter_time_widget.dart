import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mumin/app/models/PrayerTimes.dart';
import 'package:mumin/app/screens/sahriIfter.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class SahariIfterTime extends StatefulWidget {
  final PrayerTimes prayerTimes;
  const SahariIfterTime({super.key, required this.prayerTimes});

  @override
  _SahariIfterTimeState createState() => _SahariIfterTimeState();
}

class _SahariIfterTimeState extends State<SahariIfterTime> {
  late Timer _timer;
  String remainingTime = '০০ঃ০০ঃ০০';

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateCountdown();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateCountdown() {
    DateTime now = DateTime.now();

    // Parse Iftar time from string
    List<String> iftarParts = widget.prayerTimes.ifter().split(':');
    DateTime iftarTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(iftarParts[0]),
      int.parse(iftarParts[1]),
    );

    Duration diff = iftarTime.difference(now);
    
    if (diff.isNegative) {
      setState(() {
        remainingTime = '০০ঃ০০ঃ০০'; // If Iftar time has passed
      });
      return;
    }

    String hours = convertToBanglaNumbers(diff.inHours.toString().padLeft(2, '0'));
    String minutes = convertToBanglaNumbers((diff.inMinutes % 60).toString().padLeft(2, '0'));
    String seconds = convertToBanglaNumbers((diff.inSeconds % 60).toString().padLeft(2, '0'));

    setState(() {
      remainingTime = '$hours:$minutes:$seconds';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 237, 255, 237),
        border: Border.all(width: 1.5, color: const Color.fromARGB(255, 213, 248, 213)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SahriifterScreen(
                      sahri: widget.prayerTimes.sahri(),
                      ifter: widget.prayerTimes.ifter(),
                    )),
                  );
                },
                child: Icon(Icons.fullscreen_exit),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              // First Column (Sahri Time)
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        convertToBanglaNumbers(widget.prayerTimes.sahri()),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Text('সাহরির শেষ'),
                      SizedBox(height: 16),
                      Text('এলার্ম', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
              Container(width: 1, height: 110, color: Colors.grey),

              // Second Column (Iftar Time)
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        convertToBanglaNumbers(widget.prayerTimes.ifter()),
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 5),
                      Text('ইফতারের শুরু'),
                      SizedBox(height: 16),
                      Text('এলার্ম', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
              Container(width: 1, height: 110, color: Colors.grey),

              // Third Column (Countdown Timer)
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(remainingTime, style: TextStyle(fontSize: 20)),
                      SizedBox(height: 5),
                      Text('ইফতারের বাকি'),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
