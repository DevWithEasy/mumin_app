import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumin/app/models/Istighfer.dart';
import 'package:mumin/app/screens/isteghfer/isteghfer_details.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class IstighfarScreen extends StatefulWidget {
  const IstighfarScreen({super.key});

  @override
  State<IstighfarScreen> createState() => _IstighfarScreenState();
}

class _IstighfarScreenState extends State<IstighfarScreen> {
  List<Istighfer> _isteghfers = [];

  Future<void> _loadData() async {
    try {
      // Load the JSON file from assets
      final String jsonString =
          await rootBundle.loadString('assets/data/istegfar.json');
      // Decode the JSON string
      final List<dynamic> jsondata = jsonDecode(jsonString);

      // Update the state with the parsed data
      setState(() {
        _isteghfers = jsondata.map((json) => Istighfer.fromJson(json)).toList();
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
        title: const Text('ইস্তিগফার'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            ListView.builder(
                itemCount: _isteghfers.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(_isteghfers[index].name,
                          style: TextStyle(overflow: TextOverflow.ellipsis)),
                      leading: CircleAvatar(
                        child: Text(convertToBanglaNumbers(
                            _isteghfers[index].id.toString())),
                      ),
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Colors.grey.shade300, width: 1)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    IsteghferDetailsScreen(
                                       isteghfers: _isteghfers,
                                       currentIndex: index,
                                    )));
                      },
                    ),
                  );
                })
          ]),
        ),
      ),
    );
  }
}
