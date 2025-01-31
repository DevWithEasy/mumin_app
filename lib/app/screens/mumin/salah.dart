import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/app_add/salatur_rasul.dart';
import 'package:mumin/app/models/salah/SalahCategory.dart';
import 'package:mumin/app/screens/salah/salah_category.dart';

class SalahScreen extends StatefulWidget {
  const SalahScreen({super.key});

  @override
  State<SalahScreen> createState() => _SalahScreenState();
}

class _SalahScreenState extends State<SalahScreen> {
  List<SalahCategory> _categories = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/salah/salah.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Update the state with the parsed data
      setState(() {
        _categories =
            jsonData.map((json) => SalahCategory.fromJson(json)).toList();
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
              AppSalaturRasul(),
              SizedBox(height: 8),
              ListView.builder(
                itemCount: _categories.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(
                        category.title,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      leading: Image.asset(
                        category.image,
                        width: 40, // Fixed width
                        height: 40, // Fixed height
                        fit: BoxFit
                            .cover, // Ensures the image fills the space properly
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SalahCategoryScreen(category: category),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
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
