import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/ruqyah/RuqyahDetails.dart';

class RuqyahDetailsScreen extends StatefulWidget {
  final int id;
  const RuqyahDetailsScreen({super.key, required this.id});

  @override
  State<RuqyahDetailsScreen> createState() => _RuqyahDetailsScreenState();
}

class _RuqyahDetailsScreenState extends State<RuqyahDetailsScreen> {
    List<RuqyahDetails> _categories = [];
  List<RuqyahDetails> _filteredCategories = [];

  Future<void> _loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/ruqyah/ruqyah_details.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        _categories =
            jsonData.map((json) => RuqyahDetails.fromJson(json)).toList();
        
        // Filter categories based on the widget's ID
        _filteredCategories = _categories
            .where((category) => category.subcatId== widget.id)
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
        title: Text('Ruqyah Details'),
      ),
      body: Center(
        child: Text('Ruqyah Details Screen'),
      ),
    );
  }
}