import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/Sura.dart';
import 'package:mumin/app/screens/quran/sura.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List<Sura> _suras = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/quran_suras.json');

      // Decode the JSON string as a List
      final List<dynamic> jsonData = jsonDecode(jsonString);

      // Update the state with the parsed data
      setState(() {
        _suras = jsonData.map((json) => Sura.fromJson(json)).toList();
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
        title: Text('কুরআন'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/mumin/quran.png',
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
            _suras.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _suras.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = _suras[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SuraScreen(
                                id: item.id.toString(),
                                name : item.transliteration ?? '',
                                bnName: item.translation ?? '',
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
                              CircleAvatar(
                                child: Text(item.id.toString()),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.transliteration ?? ''),
                                  Text(item.translation ?? '')
                                ],
                              )),
                              Column(
                                children: [
                                  Text('আয়াত'),
                                  Text('${convertToBanglaNumbers(
                                      item.totalVerses.toString())} টি')
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
