import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class SalahScreen extends StatelessWidget {
  const SalahScreen({super.key});
  final String html = '<p><strong>১. তাহারাত বা পবিত্রতা অর্জন:&nbsp;</strong>প্রথমে ওযু করে পবিত্র হতে হবে। কারণ পবিত্রতাবিহীন সালাত কবুল হয় না (মুসলিম: ২২৪)। তবে কোন কারণে গোসল ফরয হলে, এর পূর্বে অবশ্যই ফরয গোসল সম্পন্ন করে নিতে হবে। ইসলামে যেকোন আমলের ক্ষেত্রে পবিত্রতা অর্জন অপরিহার্য একটি বিষয়। প্রত্যেক মুসলিম নর-নারীর জন্য এ বিষয়ের জ্ঞান অর্জন ফরয।</p><p><br></p>';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salah'),
      ),
      body: Center(
        child: Column(
          children: [
            Html(data: html)
          ],
        ),
      ),
    );
  }
}
