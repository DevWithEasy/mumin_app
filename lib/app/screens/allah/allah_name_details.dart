import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mumin/app/models/AllahName.dart';

class AllahNameDetailsScreen extends StatefulWidget {
  final int currentIndex;
  final int id;

  const AllahNameDetailsScreen({
    super.key,
    required this.currentIndex,
    required this.id,
  });

  @override
  State<AllahNameDetailsScreen> createState() => _AllahNameDetailsScreenState();
}

class _AllahNameDetailsScreenState extends State<AllahNameDetailsScreen> {
  List<AllahName> _asmaulHusna = [];
  late AllahName _name; // Store the current name dynamically
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
      await rootBundle.loadString('assets/data/asmaul_husna.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      List<AllahName> data = jsonData.map((json) => AllahName.fromJson(json)).toList();

      // Find the initial name based on the provided ID
      AllahName? findName = data.firstWhere((name) => name.id == widget.id);

      setState(() {
        _asmaulHusna = data;
        _name = findName!;
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
        title: Text(_name.bangla),
        elevation: 1,
      ),
      body: _asmaulHusna.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
        controller: _pageController,
        itemCount: _asmaulHusna.length,
        onPageChanged: (index) {
          // Update the current name when the page changes
          setState(() {
            _currentIndex = index;
            _name = _asmaulHusna[index];
          });
        },
        itemBuilder: (context, int index) {
          final AllahName name = _asmaulHusna[index];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: double.infinity,child: Text(name.arbi, style: TextStyle(fontSize: 40),textAlign: TextAlign.center)),
                  SizedBox(height: 10),
                  RichText(
                      text: TextSpan(
                          text: 'উচ্চারণঃ  \n',
                        style: GoogleFonts.notoSerifBengali(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(text : name.bangla,
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
                            TextSpan(text : name.meaning,
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
                          text: 'ফজিলতঃ \n',
                          style: GoogleFonts.notoSerifBengali(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text : name.faz,
                              style: GoogleFonts.notoSerifBengali(
                                fontWeight: FontWeight.normal, // Non-bold
                                color: Colors.black,
                              ),)
                          ]
                      )
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}