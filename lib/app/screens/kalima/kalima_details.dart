import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mumin/app/models/AllahName.dart';
import 'package:mumin/app/models/Kalima.dart';

class KalimaDetailsScreen extends StatefulWidget {
  final int currentIndex;
  final int id;

  const KalimaDetailsScreen({
    super.key,
    required this.currentIndex,
    required this.id,
  });

  @override
  State<KalimaDetailsScreen> createState() => _KalimaDetailsScreenState();
}

class _KalimaDetailsScreenState extends State<KalimaDetailsScreen> {
  List<Kalima> _kalimas = [];
  late Kalima _kalima; // Store the current name dynamically
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final String jsonString =
      await rootBundle.loadString('assets/data/kalimas.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      List<Kalima> data = jsonData.map((json)=>Kalima.fromJson(json)).toList();

      // Find the initial name based on the provided ID
      Kalima? findKalima = data.firstWhere((name) => name.id == widget.id);

      setState(() {
        _kalimas = data;
        _kalima = findKalima!;
        _pageController = PageController(initialPage: _currentIndex);
      });
    } catch (e) {
      print('Error loading or parsing JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_kalima.title),
        elevation: 1,
      ),
      body: _kalimas.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
        controller: _pageController,
        itemCount: _kalimas.length,
        onPageChanged: (index) {
          // Update the current name when the page changes
          setState(() {
            _currentIndex = index;
            _kalima = _kalimas[index];
          });
        },
        itemBuilder: (context, int index) {
          final Kalima kalima = _kalimas[index];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(kalima.explain),
                  SizedBox(height: 30),
                  SizedBox(width: double.infinity,child: Text(kalima.arabic, style: TextStyle(fontSize: 20),textAlign: TextAlign.right)),
                  SizedBox(height: 10),
                  RichText(
                      text: TextSpan(
                          text: 'উচ্চারণঃ  \n',
                          style: GoogleFonts.notoSerifBengali(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text : kalima.punctuation,
                              style: GoogleFonts.notoSerifBengali(
                                fontWeight: FontWeight.normal, // Non-bold
                                color: Colors.black,
                              ),)
                          ]
                      )
                  ),
                  SizedBox(height: 10),
                  RichText(
                      text: TextSpan(
                          text: 'অর্থঃ  \n',
                          style: GoogleFonts.notoSerifBengali(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text : kalima.translation,
                              style: GoogleFonts.notoSerifBengali(
                                fontWeight: FontWeight.normal, // Non-bold
                                color: Colors.black,
                              ),)
                          ]
                      )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}