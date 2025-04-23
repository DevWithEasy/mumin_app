import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/components/kalima_text_widget.dart';
import 'package:mumin/app/models/Kalima.dart';
import 'package:mumin/app/screens/kalima/kalima_details.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class KalimaScreen extends StatefulWidget {
  const KalimaScreen({super.key});

  @override
  State<KalimaScreen> createState() => _KalimaScreenState();
}

class _KalimaScreenState extends State<KalimaScreen> {
  List<Kalima> _kalimas = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString = await rootBundle.loadString('assets/data/kalimas.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      List<Kalima> data = jsonData.map((json)=>Kalima.fromJson(json)).toList();
      setState(() {
        _kalimas = data;
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
                    SizedBox(height: 24),
                  ],
                ),
              ),
              _kalimas.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                itemCount: _kalimas.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final Kalima kalima = _kalimas[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>KalimaDetailsScreen(
                        id : kalima.id,
                        currentIndex: index,
                      )));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(child: Text(convertToBanglaNumbers(kalima.id.toString()))),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(kalima.title)
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_sharp,size: 16)
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
