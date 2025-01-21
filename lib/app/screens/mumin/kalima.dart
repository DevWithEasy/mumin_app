import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/kalima_text_widget.dart';

class KalimaScreen extends StatefulWidget {
  const KalimaScreen({super.key});

  @override
  State<KalimaScreen> createState() => _KalimaScreenState();
}

class _KalimaScreenState extends State<KalimaScreen> {
  List<dynamic> kalimas = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString = await rootBundle.loadString('assets/data/kalimas.json');
      // Decode the JSON string
      final List<dynamic> data = jsonDecode(jsonString);
      // Update the state with the parsed data
      setState(() {
        kalimas = data;
      });
    } catch (e) {
      // Handle any errors during loading or parsing
      // print('Error loading or parsing JSON: $e');
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
        title: const Text('কালিমা'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/mumin/kalima.png',
                      height: 80,
                      width: 80,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'কালেমা ইসলামের মৌলিক বিশ্বাস সম্বলিত কয়েকটি আরবি পংক্তির নাম। এর মাধ্যমেই ইসলামের প্রথম স্তম্ভ পূর্ণতা পায়। ইসলামে কালমিার গুরুত্ব ও মর্যাদা অনেক । কালিমার মূল অবকাঠামো হচ্ছে বিশ্বাস। রাসূল সাল্লাল্লাহু আলাইহি ওয়া সাল্লাম বলেন : “যে ব্যক্তি এমতাবস্থায় মারা যায় যে সে জানে আল্লাহ ছাড়া কোন সঠিক উপাস্য নেই সে জান্নাতে যাবে।',
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: kalimas.length,
                itemBuilder: (context, index) {
                  final kalima = kalimas[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        title: Text(
                          kalima['title'] ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                KalimaText(
                                  title: '',
                                  value: kalima['explain'] ?? '',
                                ),
                                KalimaText(
                                  title: 'আরবিঃ',
                                  value: kalima['arabic'] ?? '',
                                ),
                                KalimaText(
                                  title: 'উচ্চারণঃ',
                                  value: kalima['punctuation'] ?? '',
                                ),
                                KalimaText(
                                  title: 'অর্থঃ',
                                  value: kalima['translation'] ?? '',
                                ),
                              ],
                            ),
                          ),
                        ],
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
