import 'package:flutter/material.dart';
import 'package:mumin/app/screens/loactionSettings.dart';

class HomeAppBarActions extends StatelessWidget {
  const HomeAppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LocationSettings()),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.place, color: Colors.blueGrey),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Dhaka',
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              Text(
                'Bangladesh',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(width: 16)
        ],
      ),
    );
  }
}
