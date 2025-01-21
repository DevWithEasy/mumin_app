import 'package:flutter/material.dart';
import 'package:mumin/app/screens/mumin/Allah.dart';
import 'package:mumin/app/screens/mumin/Dua.dart';
import 'package:mumin/app/screens/mumin/Hadith.dart';
import 'package:mumin/app/screens/mumin/Kalima.dart';
import 'package:mumin/app/screens/mumin/Quran.dart';
import 'package:mumin/app/screens/mumin/ramadan.dart';
import 'package:mumin/app/screens/mumin/salah.dart';
import 'package:mumin/app/screens/mumin/tasbih.dart';
import 'package:mumin/app/screens/mumin/zakat.dart';

class MuminScreen extends StatelessWidget {
  MuminScreen({super.key});
    final List<Map<String, dynamic>> items = [
    {'title': 'আল্লাহ', 'image': 'assets/images/mumin/allah.png', 'screen': AllahScreen()},
    {'title': 'দোয়া', 'image': 'assets/images/mumin/dua.png', 'screen': DuaScreen()},
    {'title': 'হাদিস', 'image': 'assets/images/mumin/hadis.png', 'screen': HadithScreen()},
    {'title': 'কালিমা', 'image': 'assets/images/mumin/kalima.png', 'screen': KalimaScreen()},
    {'title': 'কুরআন', 'image': 'assets/images/mumin/quran.png', 'screen': QuranScreen()},
    {'title': 'রোজা', 'image': 'assets/images/mumin/ramadan.png', 'screen': RamadanScreen()},
    {'title': 'নামায', 'image': 'assets/images/mumin/salah.png', 'screen': SalahScreen()},
    {'title': 'তাসবিহ', 'image': 'assets/images/mumin/tasbih.png', 'screen': TasbihScreen()},
    {'title': 'যাকাত', 'image': 'assets/images/mumin/zakat.png', 'screen': ZakatScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Image.asset(
                'assets/images/icon.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 12),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => items[index]['screen']),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border : Border.all(color : Colors.green, width: 0.5) // Example background color
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            items[index]['image'],
                            fit: BoxFit.cover,
                            height: 50, // Example fixed size
                          ),
                          const SizedBox(height: 8),
                          Text(
                            items[index]['title'],
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
