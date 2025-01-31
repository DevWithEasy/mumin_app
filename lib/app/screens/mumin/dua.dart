import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/hadith/loading_hadith_widget.dart';
import 'package:mumin/app/models/dua/DuaCategory.dart';
import 'package:mumin/app/screens/dua/dua_list.dart';

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
          await rootBundle.loadString('assets/data/dua/dua_category.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Update the state with the parsed data
      setState(() {
        _categories =
            jsonData.map((json) => DuaCategory.fromJson(json)).toList();
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
        title: Text('দোয়া'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Image.asset(
              'assets/images/dua/salah.png',
              width: 100,
              height: 100,
            ),
            SizedBox(height: 10),
            Text(
                'দোয়া হলো ইসলামে মহান আল্লাহর কাছে প্রার্থনা করা, মিনতি করা, বা সাহায্য চাওয়া। এটি একটি স্বতন্ত্র ইবাদত এবং ইসলামী উপাসনা ও আধ্যাত্মিকতার অবিচ্ছেদ্য অংশ। '),
            SizedBox(height: 12),
            _categories.isEmpty
                ? LoadingHadithWidget(text: 'দোয়া ক্যাটাগরি খোঁজা হচ্ছে')
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8),
                    itemCount: _categories.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => DuaListScreen(
                                catId: _categories[index].id,
                                catName: _categories[index].name,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              border: Border.all(
                                  color: Colors.green,
                                  width: 0.5) // Example background color
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                _categories[index].image,
                                fit: BoxFit.cover,
                                height: 50, // Example fixed size
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _categories[index].name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    })
          ],
        ),
      )),
    );
  }
}
