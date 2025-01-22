import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/hadith/hadith_name_code_widget.dart';
import 'package:mumin/app/screens/hadith/chapter.dart';
import 'package:mumin/app/utils/color_from_hex.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  List<dynamic> _books = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/hadith.json');
      // Decode the JSON string as a Map
      final Map<String, dynamic> data = jsonDecode(jsonString);
      // Update the state with the parsed data
      setState(() {
        _books = data['books']; // Access the "books" key in the Map
      });
    } catch (e) {
      // Handle any errors during loading or parsing
      // print('Error loading or parsing JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('হাদিস'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/mumin/hadis.png',
                  height: 80,
                  width: 80,
                ),
                SizedBox(height: 12),
                Text(
                  'আবূ হুরাইরাহ (রাঃ) হতে বর্ণিত। তিনি বলেন, আল্লাহ্ তা‘আলার নিরানব্বই নাম আছে, এক কম একশত নাম। যে ব্যক্তি এ (নাম) গুলোর হিফাযাত করবে সে জান্নাতে প্রবেশ করবে। আল্লাহ্ বিজোড়। তিনি বিজোড় পছন্দ করেন।\nসহীহ বুখারী (হাদিসঃ ৬৪১০)',
                ),
                SizedBox(height: 8),
              ],
            ),
            _books.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _books.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = _books[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChapterScreen(
                                id: item['id'].toString(),
                                name: item['title'],
                                hadithCount: item['number_of_hadis'].toString(),
                                code : item['abvr_code'],
                                colorCode : item['color_code'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          child: Row(
                            children: [
                              HexagonAvatar(text: item['abvr_code'],color: colorFromHex(item['color_code'])),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title']),
                                    Text(item['title_ar'])
                                  ],
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                children: [
                                  Text(convertToBanglaNumbers(item['number_of_hadis'].toString())),
                                  Text('হাদিস')
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })
          ]),
        ),
      ),
    );
  }
}
