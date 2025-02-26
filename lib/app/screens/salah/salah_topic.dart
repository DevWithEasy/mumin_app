import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mumin/app/components/app_add/salatur_rasul.dart';
import 'package:mumin/app/models/salah/SalahTopic.dart';

class SalahTopicScreen extends StatefulWidget {
  final String catName;
  final int catId;
  final int currentIndex;
  const SalahTopicScreen(
      {super.key,
      required this.catId,
      required this.catName,
      required this.currentIndex});

  @override
  State<SalahTopicScreen> createState() => _SalahTopicScreenState();
}

class _SalahTopicScreenState extends State<SalahTopicScreen> {
  List<SalahTopic> _salahTopics = [];
  late PageController _pageController;
  late int _currentIndex;

  Future<void> _loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/salah/salatur_topics.json');
      final List<dynamic> jsondata = jsonDecode(jsonString);

      setState(() {
        _salahTopics = jsondata
            .where((element) => element['category'] == widget.catId)
            .toList()
            .map((json) => SalahTopic.fromJson(json))
            .toList();

        // Initialize PageController after _salahTopics is populated
        _pageController = PageController(initialPage: _currentIndex);
      });
    } catch (e) {
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
    print(widget.currentIndex);
    print(_currentIndex);
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
        body: _salahTopics.isEmpty
            ? Center(child: CircularProgressIndicator())
            : PageView.builder(
                controller: _pageController,
                itemCount: _salahTopics.length,
                itemBuilder: (context, int index) {
                  final SalahTopic topic = _salahTopics[index];
                  return SingleChildScrollView(
                      child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Html(data: topic.description),
                        AppSalaturRasul()
                      ],
                    ),
                  ));
                }));
  }
}
