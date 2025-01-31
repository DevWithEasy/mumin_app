import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/ruqyah/RuqyahSubCategory.dart';
import 'package:mumin/app/screens/ruqyah/ruqyah_details.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class RuqyahsubcategoryScreen extends StatefulWidget {
  final int id;
  const RuqyahsubcategoryScreen({super.key, required this.id});

  @override
  State<RuqyahsubcategoryScreen> createState() =>
      _RuqyahsubcategoryScreenState();
}

class _RuqyahsubcategoryScreenState extends State<RuqyahsubcategoryScreen> {
  List<RuqyahSubCategory> _categories = [];
  List<RuqyahSubCategory> _filteredCategories = [];

  Future<void> _loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/ruqyah/sub_category.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        _categories =
            jsonData.map((json) => RuqyahSubCategory.fromJson(json)).toList();
        
        // Filter categories based on the widget's ID
        _filteredCategories = _categories
            .where((category) => category.catId== widget.id)
            .toList();
      });
    } catch (e) {
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
      appBar: AppBar(
        title: Text('Ruqyah SubCategory'),
      ),
      body: _filteredCategories.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _filteredCategories.length,
              itemBuilder: (context, index) {
                final category = _filteredCategories[index];
                return ListTile(
                  title: Text(category.subcatName),
                  leading: CircleAvatar(
                    child: Text(convertToBanglaNumbers((index+1).toString())),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RuqyahDetailsScreen(
                          id: category.subcatId,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}