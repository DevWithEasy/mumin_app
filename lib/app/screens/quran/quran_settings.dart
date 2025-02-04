import 'package:flutter/material.dart';
import 'package:mumin/app/providers/ReadProvider.dart';
import 'package:mumin/app/utils/convert_to_bangla_number.dart';
import 'package:provider/provider.dart';

class QuranSettingsScrren extends StatelessWidget {
  const QuranSettingsScrren({super.key});

  @override
  Widget build(BuildContext context) {
    final readProvider = Provider.of<Readprovider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('কুরআন সেটিংস'),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity, // Takes full width
                        child: Text(
                          "ٱلۡحَمۡدُ لِلَّهِ رَبِّ ٱلۡعَٰلَمِينَ",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: readProvider.arabicFont,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "[All] praise is [due] to Allah, Lord of the worlds",
                        style: TextStyle(
                          fontSize: readProvider.englishFont,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "সমস্ত প্রশংসা আল্লাহ্‌র প্রাপ্য, সমুদয় সৃষ্ট-জগতের রব্ব।",
                        style: TextStyle(
                          fontSize: readProvider.banglaFont,
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'আরবি ফ্রন্ট সাইজঃ (${convertToBanglaNumbers(readProvider.arabicFont.toStringAsFixed(0))})',
                    style: TextStyle(fontSize: 16),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                    ),
                    child: Slider(
                        value: readProvider.arabicFont,
                        min: 20,
                        max: 30,
                        onChanged: (value) {
                          readProvider.setArabicFont(value);
                        }),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ইংরেজি ফ্রন্ট সাইজঃ (${convertToBanglaNumbers(readProvider.englishFont.toStringAsFixed(0))})',
                    style: TextStyle(fontSize: 16),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                    ),
                    child: Slider(
                        value: readProvider.englishFont,
                        min: 12,
                        max: 20,
                        onChanged: (value) {
                          readProvider.setEnglishFont(value);
                        }),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'বাংলা ফ্রন্ট সাইজঃ (${convertToBanglaNumbers(readProvider.banglaFont.toStringAsFixed(0))})',
                    style: TextStyle(fontSize: 16),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                    ),
                    child: Slider(
                      value: readProvider.banglaFont,
                      min: 14,
                      max: 20,
                      onChanged: (value) {
                        readProvider.setBanglaFont(value);
                      },
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'বাংলা অনুবাদঃ',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      isExpanded: true,
                      value: readProvider.bnTranlator,
                      items: [
                        DropdownMenuItem(
                          value: 'jahirul_bn',
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: Text('জহিরুল ইসলাম'),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'muhiuddin_bn',
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
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
            ],
          ),
        ),
      ),
    );
  }
}
