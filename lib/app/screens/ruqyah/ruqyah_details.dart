import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mumin/app/models/ruqyah/RuqyahDetails.dart';

class RuqyahDetailsScreen extends StatefulWidget {
  final int id;
  final String catTitle;
  final String subCatTitle;
  const RuqyahDetailsScreen(
      {super.key,
      required this.id,
      required this.catTitle,
      required this.subCatTitle});

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
      print(jsonData);
      setState(() {
        _ruqiahas =
            jsonData.map((json) => RuqyahDetails.fromJson(json)).toList();

        // Find single item based on the widget's ID
        _ruqiah =
            _ruqiahas.firstWhere((ruqiah) => ruqiah.subcatId == widget.id);
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
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.catTitle, style: TextStyle(fontSize: 16)),
            Text(widget.subCatTitle,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700))
          ],
        ),
        elevation: 1,
      ),
      body: _ruqiah == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Html(
                        data: _ruqiah!.ruqyaDetails
                            .replaceAll('\n', '<br>')
                            .replaceAll('<ar>',
                                '<p dir="rtl" style="font-family:Noto Sans Arabic;">')
                            .replaceAll('</ar>', '</p>'))
                  ],
                ),
              ),
            ),
    );
  }
}
