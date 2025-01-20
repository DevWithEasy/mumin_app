import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final natigationItems = [
    {'icon': Icons.home, 'title': 'হোম'},
    {'icon': Icons.calendar_month, 'title': 'ক্যালেন্ডার'},
    {'icon': Icons.person, 'title': 'মুমিন'},
    {'icon': Icons.store, 'title': 'স্টোর'},
    {'icon': Icons.menu,'title': 'মেন্যু'},
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        items: natigationItems.map((item) {
          return BottomNavigationBarItem(
            icon: Icon(item['icon'] as IconData),
            label: item['title'] as String,
          );
        }).toList());
  }
}
