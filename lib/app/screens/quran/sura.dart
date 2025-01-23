import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/hadith/loading_hadith_widget.dart';
import 'package:mumin/app/models/SuraDetails.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class SuraScreen extends StatefulWidget {
  final String id;
  final String name;
  final String bnName;

  const SuraScreen({super.key, required this.id, required this.name, required this.bnName});

  @override
  State<SuraScreen> createState() => _SuraScreenState();
}

class _SuraScreenState extends State<SuraScreen> {
  List<SuraDeatils> _quran = [];
  SuraDeatils? selectedSura;
  String bnTranlator = 'jahirul_bn';

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/quran.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Parse JSON and find the specific Surah by id
      setState(() {
        _quran = jsonData.map((json) => SuraDeatils.fromJson(json)).toList();
        selectedSura =
            _quran.firstWhere((sura) => sura.number == int.parse(widget.id));
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
        backgroundColor: _quran.isEmpty ? Colors.white : Colors.grey.shade100,
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: selectedSura == null
                ? LoadingHadithWidget(text: 'সুরা খোঁজা হচ্ছে')// Loading state
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(
                                    selectedSura?.revelationType == 'Meccan' ? 
                                    'assets/images/makka.png' : 'assets/images/madina.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.name,
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        widget.bnName,
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'আয়াতঃ ${convertToBanglaNumbers(selectedSura!.ayahs.length.toString())} টি',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        'নাযিলঃ ${selectedSura?.revelationType == 'Meccan' ? 'মাক্কি' : 'মাদানি'}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 40),
                              child: Image.asset(
                                'assets/images/bismillah.png',
                                  ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                        itemCount: selectedSura!.ayahs.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final ayah = selectedSura!.ayahs[index];
                          return Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      convertToBanglaNumbers(
                                          (index + 1).toString()),
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(Icons.more_vert)
                                  ],
                                ),
                                SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      ayah.arabic,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
                                SizedBox(height: 10),
                                Text(
                                  ayah.english,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  bnTranlator == 'jahirul_bn'
                                      ? ayah.jahirul_bn
                                      : ayah.muhiuddin_bn,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ),
        ));
  }
}
