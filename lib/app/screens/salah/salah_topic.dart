import 'package:flutter/material.dart';

class SalahTopicScreen extends StatefulWidget {
  final int catId;
  final String catName;
  final String subCatName;
  const SalahTopicScreen(
      {super.key,
      required this.catId,
      required this.catName,
      required this.subCatName});

  @override
  State<SalahTopicScreen> createState() => _SalahTopicScreenState();
}

class _SalahTopicScreenState extends State<SalahTopicScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.catName),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // ListView.builder(
              //   itemCount: widget.category.topics.length,
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemBuilder: (context, index) {
              //     final topic = widget.category.topics[index];
              //     return ListTile(
              //       title: Text(topic.title),

              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
