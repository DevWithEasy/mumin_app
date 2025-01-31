import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/ruqyah/RuqyahCategory.dart';
import 'package:mumin/app/screens/ruqyah/ruqyah_sub_category.dart';

class RuqyahScreen extends StatefulWidget {
  const RuqyahScreen({super.key});

  @override
  State<RuqyahScreen> createState() => _RuqyahScreenState();
}

class _RuqyahScreenState extends State<RuqyahScreen> {
  List<RuqyahCategory> _categories = [];
  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/ruqyah/category.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Parse JSON and find the specific Surah by id
      setState(() {
        _categories =
            jsonData.map((json) => RuqyahCategory.fromJson(json)).toList();
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
          title: Text('Ruqyah Category'),
          elevation: 1,
        ),
        body: SingleChildScrollView(
          child: _categories.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: _categories.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          title: Text(_categories[index].categoryName),
                          leading: Image.asset(
                            _categories[index].catIcon,
                            width: 40,
                            height: 40,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RuqyahsubcategoryScreen(
                                        id: _categories[index].catId)));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.grey)
                          )
                        ),
                      );
                    }),
              ),
        ));
  }
}