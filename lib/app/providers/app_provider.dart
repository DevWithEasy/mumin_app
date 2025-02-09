import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  bool isAuto = false;
  String city = '';
  String country = '';

  void setCity(String value) {
    city = value;
    notifyListeners();
  }

  void setCountry(String value) {
    country = value;
    notifyListeners();
  }
  
  void setIsAuto(bool value) {
    isAuto = value;
    notifyListeners();
  }
}
