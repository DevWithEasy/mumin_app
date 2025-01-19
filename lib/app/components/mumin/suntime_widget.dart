import 'package:flutter/material.dart';

class SunTime extends StatelessWidget {
  const SunTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 223, 240, 253),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '১৮ রজব',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'শনিবার - ২১ জানুয়ারি',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '৮ মাঘ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ])
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(child: Icon(Icons.sunny)),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '০৭ঃ০০',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'সুর্যোদয়',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '০৭ঃ০০',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'সুর্যাস্ত',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
