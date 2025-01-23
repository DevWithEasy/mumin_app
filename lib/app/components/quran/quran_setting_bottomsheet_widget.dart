import 'package:flutter/material.dart';
import 'package:mumin/app/providers/ReadProvider.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';
import 'package:provider/provider.dart';

class QuranSettingBottomsheet extends StatelessWidget {
  const QuranSettingBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final readProvider = Provider.of<Readprovider>(context);
    return Container(
      padding: EdgeInsets.all(16),
      height: 400,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              'সেটিংস',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'আরবি ফ্রন্ট সাইজঃ (${convertToBanglaNumbers(readProvider.arabicFont.toStringAsFixed(0))})',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Slider(
                  value: readProvider.arabicFont,
                  min: 20,
                  max: 30,
                  onChanged: (value) {
                    readProvider.setArabicFont(value);
                  })
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'ইংরেজি ফ্রন্ট সাইজঃ (${convertToBanglaNumbers(readProvider.englishFont.toStringAsFixed(0))})',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Slider(
                  value: readProvider.englishFont,
                  min: 12,
                  max: 20,
                  onChanged: (value) {
                    readProvider.setEnglishFont(value);
                  })
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  'বাংলা ফ্রন্ট সাইজঃ (${convertToBanglaNumbers(readProvider.banglaFont.toStringAsFixed(0))})',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Slider(
                  value: readProvider.banglaFont,
                  min: 14,
                  max: 20,
                  onChanged: (value) {
                    readProvider.setBanglaFont(value);
                  })
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'বাংলা অনুবাদঃ',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8), // Add spacing for better UI
                Container(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded:
                        true, // Ensures full width for the dropdown button
                    value: readProvider.bnTranlator,
                    items: [
                      DropdownMenuItem(
                        value: 'jahirul_bn',
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: double
                              .infinity, // Ensures full width for the item
                          child: Text('জহিরুল ইসলাম'),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'muhiuddin_bn',
                        child: Container(
                          alignment: Alignment.centerLeft,
                          width: double
                              .infinity, // Ensures full width for the item
                          child: Text('মহিউদ্দিন'),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      readProvider.setBnTranslator(value!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
