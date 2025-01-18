import 'package:flutter/material.dart';
import 'package:mumin/app/screens/loactionSettings.dart';

class MuminScreen extends StatefulWidget {
  const MuminScreen({super.key});

  @override
  State<MuminScreen> createState() => _MuminScreenState();
}

class _MuminScreenState extends State<MuminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('মুমিন', style: TextStyle(fontSize: 18)),
        elevation: 0.1,
        backgroundColor: Colors.white,
        shadowColor: Colors.blueGrey,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  LocationSettings()),
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
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text(
            'Mumin is a traditional Indonesian',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ]),
    );
  }
}
