import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/DuaCategory.dart';
import 'package:permission_handler/permission_handler.dart';

class DuaScreen extends StatefulWidget {
  const DuaScreen({super.key});

  @override
  State<DuaScreen> createState() => _DuaScreenState();
}

class _DuaScreenState extends State<DuaScreen> {
  List<DuaCategory> _categories = [];

    Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/dua_category.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Update the state with the parsed data
      setState(() {
        _categories = jsonData.map((json) => DuaCategory.fromJson(json)).toList();
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
      appBar: AppBar(
        title: Text('Dua Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () async {
                var str = await Permission.storage.status;
                print(str);
              },
              child: Text('Check'),
            )
          ],
        ),
      ),
    );
  }
}
