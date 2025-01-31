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
  List<RuqyahDetails> _ruqiahas = [];
  RuqyahDetails? _ruqiah;

  Future<void> _loadData() async {
    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/ruqyah/ruqyah_details.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        _ruqiahas =
            jsonData.map((json) => RuqyahDetails.fromJson(json)).toList();
        
        // Find single item based on the widget's ID
        _ruqiah = _ruqiahas.firstWhere((ruqiah) => ruqiah.subcatId == widget.id);
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
      body: _ruqiah == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _ruqiah!.ruqyaDetails
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}