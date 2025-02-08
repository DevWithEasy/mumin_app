import 'package:flutter/material.dart';
import 'package:mumin/app/components/bottom_navigation_widget.dart';
import 'package:mumin/app/components/mainpage/home_appbar_widget.dart';
import 'package:mumin/app/screens/main/calender.dart';
import 'package:mumin/app/screens/main/home.dart';
import 'package:mumin/app/screens/main/menu.dart';
import 'package:mumin/app/screens/main/mumin.dart';
import 'package:mumin/app/screens/main/store.dart';

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
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('মুমিন',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        elevation: 1,
        backgroundColor: Colors.white,
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
