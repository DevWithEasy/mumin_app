import 'package:flutter/material.dart';
import 'package:mumin/app/providers/ReadProvider.dart';
import 'package:mumin/app/screens/splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MuminApp extends StatelessWidget {
  const MuminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_)=>Readprovider())
        ],
        child: Builder(builder: (BuildContext contex) {
          return MaterialApp(
            title: 'Mumin',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                textTheme: GoogleFonts.notoSerifBengaliTextTheme()),
            home: SplashScreen(),
          );
        }));
  }
}
