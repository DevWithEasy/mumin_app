import 'package:flutter/material.dart';

class Readprovider extends ChangeNotifier {
  double arabicFont = 20;
  double englishFont = 12;
  double banglaFont = 14;
  String bnTranlator = 'muhiuddin_bn';

  void setArabicFont(double arabicFont) {
    this.arabicFont = arabicFont;
    notifyListeners();
  }
  
  void setEnglishFont(double englishFont) {
    this.englishFont = englishFont;
    notifyListeners();
  }
  
  void setBanglaFont(double banglaFont) {
    this.banglaFont = banglaFont;
    notifyListeners();
  }
  
  void setBnTranslator(String bnTranslator) {
    bnTranlator = bnTranslator;
    notifyListeners();
  }
}
