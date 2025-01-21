import 'package:flutter/material.dart';

class KalimaText extends StatelessWidget {
  final String? title;
  final String value;

  const KalimaText({
    super.key,
    this.title, // Nullable title
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null && title!.isNotEmpty)
          Text(
            title!,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
