import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mumin/app/providers/ReadProvider.dart';
import 'package:mumin/app/screens/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MuminApp extends StatefulWidget {
  const MuminApp({super.key});

  @override
  State<MuminApp> createState() => _MuminAppState();
}

class _MuminAppState extends State<MuminApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async{
    await Future.delayed(Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

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
            home: MainScreen(),
          );
        }));
  }
}
