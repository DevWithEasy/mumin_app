import 'package:flutter/material.dart';

class LoadingHadithWidget extends StatelessWidget {
  final String text;
  const LoadingHadithWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: Text('$text ...'),
    );
  }
}
