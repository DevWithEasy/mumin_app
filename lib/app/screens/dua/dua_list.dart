import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/hadith/loading_hadith_widget.dart';
import 'package:mumin/app/models/Dua.dart';
import 'package:mumin/app/screens/dua/dua_details.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class DuaListScreen extends StatefulWidget {
  final int catId;
  final String catName;
  const DuaListScreen({super.key, required this.catId, required this.catName});

  @override
  State<DuaListScreen> createState() => _DuaListScreenState();
}

class _DuaListScreenState extends State<DuaListScreen> {
  List<Dua> _duaList = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/dua/dua_collection.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Filter the data by category and map it to the Dua model
      final filteredDuas = jsonData
          .where((item) => item['category'] == widget.catId)
          .map((json) => Dua.fromJson(json))
          .toList();

      // Update the state with the filtered data
      setState(() {
        _duaList = filteredDuas;
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
        title: Text('${widget.catName} এর দোয়াসমুহ'),
        elevation: 1,
      ),
      body: _duaList.isEmpty
          ? const Center(
              child: LoadingHadithWidget(text: 'দোয়া খোঁজা হচ্ছে'),
            )
          : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: _duaList.length,
                itemBuilder: (context, index) {
                  final dua = _duaList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: ListTile(
                        title: Text(dua.name),
                        leading: CircleAvatar(
                          child: Text(convertToBanglaNumbers((index+1).toString())),
                        ),
                        onTap: (){
                          // Navigate to the DuaDetailsScreen
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DuaDetailsScreen(
                              duaList: _duaList,
                              currentIndex: index,
                            ),
                          ));
                        },
                      ),
                    ),
                  );
                },
              ),
          ),
    );
  }
}
