import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/SalaturCategory.dart';
import 'package:mumin/app/screens/salah/salatur_topic.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class SalaturRasulScreen extends StatefulWidget {
  const SalaturRasulScreen({super.key});

  @override
  State<SalaturRasulScreen> createState() => _SalaturRasulScreenState();
}

class _SalaturRasulScreenState extends State<SalaturRasulScreen> {
  List<SalaturCategory> _categories = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/salah/salatur_category.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Update the state with the parsed data
      setState(() {
        _categories =
            jsonData.map((json) => SalaturCategory.fromJson(json)).toList();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('নামায'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ListView.builder(
                itemCount: _categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = _categories[index];

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.heading,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const Divider(),
                      // Use ListView.builder to render topics for better performance
                      ListView.builder(
                        itemCount: category.topics.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, topicIndex) {
                          final topic = category.topics[topicIndex];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(topic.title),
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey.shade200,
                                child: Text(
                                  convertToBanglaNumbers(
                                      (topicIndex + 1).toString()),
                                ),
                              ),
                              shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: Colors.grey.shade300, width: 1)),
                              onTap: () {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (contex)=>SalaturTopicScreen(
                                    catName: category.heading,
                                    catId: category.id,
                                    currentIndex: topicIndex,
                                  )));
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16), // Space between categories
                    ],
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
