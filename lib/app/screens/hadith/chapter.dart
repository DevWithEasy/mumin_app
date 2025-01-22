import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mumin/app/components/hadith/loading_hadith_widget.dart';
import 'package:mumin/app/models/Chapter.dart';
import 'package:mumin/app/screens/hadith/hadiths.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class ChapterScreen extends StatefulWidget {
  final String name;
  final String code;
  final String colorCode;
  final String hadithCount;
  final String id;
  const ChapterScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.hadithCount, 
      required this.code, required this.colorCode
      });

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  List<Chapter> _chapters = [];

  Future<void> fetchData() async {
    final url =
        Uri.parse('https://ihadis.onrender.com/api/book/chapter/${widget.id}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (mounted) {
          setState(() {
            _chapters = List<Chapter>.from(
                data['data'].map((item) => Chapter.fromJson(item)));
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
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _chapters.isEmpty ? Colors.white : Colors.grey.shade100,
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name, style: TextStyle(fontSize: 18)),
            Text('${convertToBanglaNumbers(widget.hadithCount)} টি হাদিস',
                style: TextStyle(fontSize: 14)),
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
              _chapters.isEmpty
                  ? LoadingHadithWidget(text: 'হাদিসের অধ্যায় খোঁজা হচ্ছে')
                  : ListView.builder(
                      itemCount: _chapters.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HadithsScreen(
                                  code : widget.code,
                                  colorCode: widget.colorCode ,
                                  bookId: widget.id,
                                  chapterId: _chapters[index].chapterChapterId.toString(),
                                  bookTitle: widget.name,
                                  chapterTitle: _chapters[index].title?? '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Text(convertToBanglaNumbers(_chapters[index].number.toString())),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _chapters[index].title ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      SizedBox(height: 5),
                                      Text('হাদিসের রেঞ্জঃ ${_chapters[index].hadisRange}')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
            ],
          ),
        ),
      ),
    );
  }
}
