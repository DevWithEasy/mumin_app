import 'package:flutter/material.dart';
import 'package:mumin/app/screens/sahriIfter.dart';

class SahariIfterTime extends StatelessWidget {
  const SahariIfterTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 237, 255, 237),
          border: Border.all(
              width: 1.5, color: const Color.fromARGB(255, 213, 248, 213))),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SahriifterScreen()),
                  );
                },
                child: Icon(
                  Icons.fullscreen_exit,
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              // First Column
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('৫ঃ২৫', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 5),
                      Text('সাহরির শেষ'),
                      SizedBox(height: 16),
                      Text('এলার্ম', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 110,
                color: Colors.grey,
              ),
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('৫ঃ২৫', style: TextStyle(fontSize: 20)),
                      SizedBox(height: 5),
                      Text('ইফতারের শুরু'),
                      SizedBox(height: 16),
                      Text('এলার্ম', style: TextStyle(color: Colors.green)),
                    ],
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 110,
                color: Colors.grey,
              ),
              Expanded(
                child: SizedBox(
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('৫ঃ২৫ঃ১২', style: TextStyle(fontSize: 20)),
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
