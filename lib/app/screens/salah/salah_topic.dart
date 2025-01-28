import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mumin/app/models/SalahTopic.dart';

class SalahTopicScreen extends StatefulWidget {
  final String catName;
  final int catId;
  final int currentIndex;
  const SalahTopicScreen(
      {super.key,
      required this.catId,
      required this.currentIndex,
      required this.catName});

  @override
  State<SalahTopicScreen> createState() => _SalahTopicScreenState();
}

class _SalahTopicScreenState extends State<SalahTopicScreen> {
  List<SalahTopic> _salahTopics = [];
  late PageController _pageController;
  late int _currentIndex;

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/salah/salah_topics.json');
      // Decode the JSON string
      final List<dynamic> jsondata = jsonDecode(jsonString);

      // Update the state with the parsed data
      setState(() {
        _salahTopics = jsondata
            .where((element) => element['category'] == widget.catId)
            .toList()
            .map((json) => SalahTopic.fromJson(json))
            .toList();
      });
    } catch (e) {
      // Handle any errors during loading or parsing
      print('Error loading or parsing JSON: $e');
    }
  }



  @override
  void initState() {
    super.initState();
    _loadData();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.catName),
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _salahTopics.length,
          itemBuilder: (context,int index){
            final SalahTopic topic = _salahTopics[index];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Html(data: topic.description),
                    
                    Container(
                      color : Colors.grey.shade200,
                      child: Html(data: topic.reference),
                    )
                  ],
                ),
              )
            );
          }
        ));
  }
}
