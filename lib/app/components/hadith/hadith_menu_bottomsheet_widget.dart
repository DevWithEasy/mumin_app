import 'package:flutter/material.dart';

class HadithMenuBottomsheet extends StatelessWidget {
  const HadithMenuBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      color: Colors.white,
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'অন্যান্য অপশন',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [Icon(Icons.copy, color: Colors.green), 
            SizedBox(width: 8), 
            Text('আরবি কপি')],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(Icons.copy, color: Colors.green),
              SizedBox(width: 8),
              Text('বাংলা অনুবাদ কপি')
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(Icons.copy, color: Colors.green),
              SizedBox(width: 8),
              Text('সম্পুর্ণ হাদিস কপি')
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(Icons.share, color: Colors.green),
              SizedBox(width: 8),
              Text('টেক্সট শেয়ার করুন')
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Icon(Icons.info,color: Colors.green),
              SizedBox(width: 8),
              Text('রিপোর্ট করুন')
            ],
          ),
        ],
      ),
    );
  }
}
