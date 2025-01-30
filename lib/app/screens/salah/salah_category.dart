import 'package:flutter/material.dart';
import 'package:mumin/app/models/SalahCategory.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';

class SalahCategoryScreen extends StatefulWidget {
  final SalahCategory category;
  const SalahCategoryScreen({super.key, required this.category});

  @override
  State<SalahCategoryScreen> createState() => _SalahTopicScreenState();
}

class _SalahTopicScreenState extends State<SalahCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.category.title),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              ListView.builder(
                itemCount: widget.category.topics.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final topic = widget.category.topics[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      title: Text(topic.title),
                      leading: CircleAvatar(
                        child: Text(
                          convertToBanglaNumbers(topic.id.toString()),
                        ),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => SalahCategoryScreen(category: topic),
                        //   ),
                        // );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey),
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