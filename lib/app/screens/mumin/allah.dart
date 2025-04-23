import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/AllahName.dart';
import 'package:mumin/app/screens/allah/allah_name_details.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class AllahScreen extends StatefulWidget {
  const AllahScreen({super.key});

  @override
  _AllahScreenState createState() => _AllahScreenState();
}

class _AllahScreenState extends State<AllahScreen> {
  List<AllahName> _asmaulHusna = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/asmaul_husna.json');
      // Decode the JSON string
      final List<dynamic> jsonData = jsonDecode(jsonString);
      List<AllahName> data = jsonData.map((json)=>AllahName.fromJson(json)).toList();
      setState(() {
        _asmaulHusna = data;
      });
    } catch (e) {
      // Handle any errors during loading or parsing
      print('Error loading or parsing JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('আসমাউল হুসনা'),
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
                        'assets/images/mumin/allah.png',
                        height: 80,
                        width: 80,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'আবূ হুরাইরাহ (রাঃ) হতে বর্ণিত। তিনি বলেন, আল্লাহ্ তা‘আলার নিরানব্বই নাম আছে, এক কম একশত নাম। যে ব্যক্তি এ (নাম) গুলোর হিফাযাত করবে সে জান্নাতে প্রবেশ করবে। আল্লাহ্ বিজোড়। তিনি বিজোড় পছন্দ করেন।\nসহীহ বুখারী (হাদিসঃ ৬৪১০)',
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
                _asmaulHusna.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemCount: _asmaulHusna.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = _asmaulHusna[index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AllahNameDetailsScreen(
                                id : item.id,
                                currentIndex: index,
                              )));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(child: Text(convertToBanglaNumbers(item.id.toString()))),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.arbi),
                                      Text(item.bangla)
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
        ));
  }
}
