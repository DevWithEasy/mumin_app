import 'package:flutter/material.dart';

class HadithMenuBottomsheet extends StatelessWidget {
  const HadithMenuBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.copy),
              Text('আরবি কপি')
            ],
          )
        ],
      ),
    );
  }
}