import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/hadith/hadith_menu_bottomsheet_widget.dart';
import 'package:mumin/app/components/hadith/hadith_name_code_widget.dart';
import 'package:mumin/app/components/hadith/loading_hadith_widget.dart';
import 'package:mumin/app/models/Hadith.dart';
import 'package:http/http.dart' as http;
import 'package:mumin/app/models/Validity.dart';
import 'package:mumin/app/utils/color_from_hex.dart';

class HadithsScreen extends StatefulWidget {
  final String code;
  final String colorCode;
  final String bookId;
  final String chapterId;
  final String bookTitle;
  final String chapterTitle;
  const HadithsScreen(
      {super.key,
      required this.bookId,
      required this.chapterId,
      required this.bookTitle,
      required this.chapterTitle,
      required this.code,
      required this.colorCode});

  @override
  State<HadithsScreen> createState() => _HadithsScreenState();
}

class _HadithsScreenState extends State<HadithsScreen> {
  List<Hadith> _hadiths = [];
  List<Validity> _validities = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/validities.json');
      // Decode the JSON string
      final List<dynamic> data = jsonDecode(jsonString);
      // Update the state with the parsed data
      setState(() {
        _validities = data.map((item) => Validity.fromJson(item)).toList();
      });
    } catch (e) {
      // Handle any errors during loading or parsing
      // print('Error loading or parsing JSON: $e');
    }
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://ihadis.onrender.com/api/book/hadith/${widget.bookId}/${widget.chapterId}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            _hadiths = List<Hadith>.from(
                data['data'].map((item) => Hadith.fromJson(item)));
          });
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _hadiths.isEmpty ? Colors.white : Colors.grey.shade100,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.bookTitle, style: TextStyle(fontSize: 18)),
            Text(widget.chapterTitle, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Column(
                children: [],
              ),
              _hadiths.isEmpty
                  ? LoadingHadithWidget(text: 'হাদিস খোঁজা হচ্ছে')
                  : ListView.builder(
                      itemCount: _hadiths.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final hadith = _hadiths[index];
                        return Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    overflow: TextOverflow.clip,
                                    text: TextSpan(
                                      text: '${hadith.number} ',
                                      style: TextStyle(color: Colors.blue),
                                      children: [
                                        if (hadith.number != hadith.title)
                                          TextSpan(
                                            text: hadith.title ?? '',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                      ],
                                    ),
                                  ),
                                  if (hadith.preface != null &&
                                      hadith.preface!.isNotEmpty) ...[
                                    SizedBox(height: 5),
                                    Divider(height: 0.5),
                                    SizedBox(height: 8),
                                    Text(
                                      hadith.preface ?? '',
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            ListView.builder(
                              itemCount: hadith.hadiths.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final hadithItem = hadith.hadiths[index];
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(12),
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            HexagonAvatar(
                                              text: widget.code,
                                              color: colorFromHex(
                                                  widget.colorCode),
                                            ),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(hadithItem.bookName ??
                                                        ''),
                                                    Text(
                                                      hadithItem.hadithKey ??
                                                          '',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    ),
                                                  ]),
                                            ),
                                            Row(children: [
                                              SizedBox(
                                                height: 35,
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      final Validity validity =
                                                          _validities.singleWhere(
                                                              (item) =>
                                                                  item.title ==
                                                                  hadithItem
                                                                      .grade);
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                    validity.title ??
                                                                        ""),
                                                                content: Text(
                                                                    validity.description ??
                                                                        ''),
                                                              ));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      elevation: 0,
                                                      backgroundColor:
                                                          (colorFromHex(hadithItem
                                                                  .gradeColor ??
                                                              '')),
                                                      foregroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                    ),
                                                    child: Text(
                                                        hadithItem.grade ??
                                                            '')),
                                              ),
                                              SizedBox(width: 8),
                                              InkWell(
                                                  onTap: () {
                                                    showModalBottomSheet(
                                                        context: context,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.vertical(
                                                                  top: Radius
                                                                      .circular(
                                                                          16)),
                                                        ),
                                                        builder: (context) {
                                                          return HadithMenuBottomsheet();
                                                        });
                                                  },
                                                  child: Icon(Icons.more_vert))
                                            ])
                                          ]),
                                      SizedBox(height: 8),
                                      Text(
                                        textDirection: TextDirection.rtl,
                                        hadithItem.ar ?? '',
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        hadithItem.narrator ?? '',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      SizedBox(height: 8),
                                      Text(hadithItem.bn ?? ''),
                                      if (hadithItem.note != null &&
                                          hadithItem.note!.isNotEmpty) ...[
                                        SizedBox(height: 8),
                                        Divider(height: 0.5),
                                        SizedBox(height: 8),
                                        Text(
                                          hadithItem.note ?? '',
                                          style: TextStyle(
                                              color: Colors.grey.shade700),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
