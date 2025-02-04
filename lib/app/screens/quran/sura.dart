import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/hadith/loading_hadith_widget.dart';
import 'package:mumin/app/models/quran/SuraDetails.dart';
import 'package:mumin/app/providers/ReadProvider.dart';
import 'package:mumin/app/screens/quran/quran_settings.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';
import 'package:provider/provider.dart';

class SuraScreen extends StatefulWidget {
  final String id;
  final String name;
  final String bnName;

  const SuraScreen(
      {super.key, required this.id, required this.name, required this.bnName});

  @override
  State<SuraScreen> createState() => _SuraScreenState();
}

class _SuraScreenState extends State<SuraScreen> {
  List<SuraDeatils> _quran = [];
  SuraDeatils? selectedSura;

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/quran/quran.json');

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
    final readProvider = Provider.of<Readprovider>(context);
    return Scaffold(
        backgroundColor: _quran.isEmpty ? Colors.white : Colors.grey.shade100,
        appBar: AppBar(
          title: Text(widget.name),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QuranSettingsScrren()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: selectedSura == null
                ? LoadingHadithWidget(text: 'সুরা খোঁজা হচ্ছে') // Loading state
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
                                    selectedSura?.revelationType == 'Meccan'
                                        ? 'assets/images/quran/makka.png'
                                        : 'assets/images/quran/madina.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Image.asset(
                                'assets/images/quran/bismillah.png',
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
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    content: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${selectedSura?.englishName} ${convertToBanglaNumbers(selectedSura!.number.toString())}:${convertToBanglaNumbers((index + 1).toString())}',
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          Row(
                                                            children: [],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        child: Icon(Icons.more_horiz))
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
                                        fontSize: readProvider.arabicFont,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
                                SizedBox(height: 10),
                                Text(
                                  ayah.english,
                                  style: TextStyle(
                                    fontSize: readProvider.englishFont,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  readProvider.bnTranlator == 'jahirul_bn'
                                      ? ayah.jahirul_bn
                                      : ayah.muhiuddin_bn,
                                  style: TextStyle(
                                    fontSize: readProvider.banglaFont,
                                    color: Colors.black,
                                  ),
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
