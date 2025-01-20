import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'হোম',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month),
        label: 'ক্যালেন্ডার',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'মুমিন',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.follow_the_signs),
        label: 'ইসলাম',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.menu),
        label: 'মেন্যু',
      ),
    ]);
  }
}
