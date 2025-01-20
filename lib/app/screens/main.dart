import 'package:flutter/material.dart';
import 'package:mumin/app/components/bottom_navigation_widget.dart';
import 'package:mumin/app/components/mumin/home_appbar_widget.dart';
import 'package:mumin/app/screens/calender.dart';
import 'package:mumin/app/screens/home.dart';
import 'package:mumin/app/screens/store.dart';
import 'package:mumin/app/screens/menu.dart';
import 'package:mumin/app/screens/mumin.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CalenderScreen(),
    MuminScreen(),
    StoreScreen(),
    MenuScreen(),
  ];

  void _onItemTapped(int index) {
    print(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'মুমিন', 
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)
        ),
        elevation: 0.4,
        backgroundColor: Colors.white,
        shadowColor: Colors.blueGrey,
        actions: [HomeAppBarActions()],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
