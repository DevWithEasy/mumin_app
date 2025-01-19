import 'package:flutter/material.dart';
import 'package:mumin/app/components/bottom_navigation_widget.dart';
import 'package:mumin/app/components/mumin/home_appbar_widget.dart';
import 'package:mumin/app/components/mumin/suntime_widget.dart';

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
          HomeAppBarActions()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SunTime()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
