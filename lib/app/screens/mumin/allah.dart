import 'package:flutter/material.dart';
import 'dart:convert'; // For JSON decoding
import 'package:flutter/services.dart';
import 'package:mumin/app/components/kalima_text_widget.dart'; // For rootBundle

class AllahScreen extends StatefulWidget {
  const AllahScreen({super.key});

  @override
  _AllahScreenState createState() => _AllahScreenState();
}

class _AllahScreenState extends State<AllahScreen> {
  List<dynamic> _asmaulHusna = [];

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
      final List<dynamic> data = jsonDecode(jsonString);
      // Update the state with the parsed data
      setState(() {
        _asmaulHusna = data;
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
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                _asmaulHusna.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: _asmaulHusna.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = _asmaulHusna[index];
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Theme(
                              data: Theme.of(context)
                                  .copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: Text(
                                  item['bangla'] ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16,right: 16, bottom: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'আরবি:  ${item['arbi'] ?? ''}',
                                          style: const TextStyle(fontSize: 16)
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'অর্থ:  ${item['meaning'] ?? ''}',
                                          style: const TextStyle(fontSize: 16)
                                        ),
                                        SizedBox(height: 8),
                                        KalimaText(
                                          title: 'ফযীলতঃ',
                                          value: item['faz'] ?? '',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          // return Card(
                          //   margin: EdgeInsets.only(bottom: 10),
                          //   child: ListTile(
                          //     leading: CircleAvatar(
                          //       child: Text(item['id'].toString()),
                          //     ),
                          //     title: Text(
                          //       item['bangla'] ?? '',
                          //       style:
                          //           const TextStyle(fontWeight: FontWeight.bold),
                          //     ),
                          //     subtitle: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Text('আরবি: ${item['arbi'] ?? ''}'),
                          //         Text('অর্থ: ${item['meaning'] ?? ''}'),
                          //         Text('ফযীলত: ${item['faz'] ?? ''}'),
                          //       ],
                          //     ),
                          //     isThreeLine: true,
                          //   ),
                          // );
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
