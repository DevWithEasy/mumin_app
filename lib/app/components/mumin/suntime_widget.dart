import 'package:flutter/material.dart';

class SunTime extends StatelessWidget {
  const SunTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 201, 228, 248),
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(
          image: AssetImage('assets/images/suntime.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max, // Ensure the Row occupies full width
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the first column vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center the content horizontally
              children: [
                Text(
                  '১৮ রজব',
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
                Text(
                  'শনিবার - ২১ জানুয়ারি',
                  style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 240, 237, 237)),
                ),
                Text(
                  '৮ মাঘ',
                  style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 240, 237, 237)),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.sunny, color: Colors.white),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '০৭ঃ০০',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'সুর্যোদয়',
                      style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 240, 237, 237)),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '০৭ঃ০০',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'সুর্যাস্ত',
                      style: TextStyle(fontSize: 16,color: const Color.fromARGB(255, 240, 237, 237)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}