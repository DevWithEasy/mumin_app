import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
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
}
