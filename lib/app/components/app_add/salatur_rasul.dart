import 'package:flutter/material.dart';

class AppSalaturRasul extends StatelessWidget {
  const AppSalaturRasul({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 1.0,
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/salah/salah.png',
            height: 40,
            width: 40,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('রাসুলের সালাত',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('হাদিস ও দলিলের রেফারেন্সসহ',
                    style: TextStyle(color: Colors.grey.shade700))
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.blue.shade50, shape: BoxShape.circle),
            child: Center(
              child: Image.asset(
                'assets/images/playstore.png',
                height: 25,
                width: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
