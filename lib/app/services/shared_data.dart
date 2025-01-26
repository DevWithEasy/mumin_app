import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  // Singleton instance
  static final SharedData _instance = SharedData._internal();
  factory SharedData() => _instance;
  SharedData._internal();

  SharedPreferences? _preferences;

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<bool> saveString(String key, String value) async {
    if (_preferences == null) await init();
    return _preferences!.setString(key, value);
  }

  // Retrieve a string value
  String? getString(String key) {
    if (_preferences == null) return null;
    return _preferences!.getString(key);
  }

  // Save a boolean value
  Future<bool> saveBool(String key, bool value) async {
    if (_preferences == null) await init();
    return _preferences!.setBool(key, value);
  }

  // Retrieve a boolean value
  bool? getBool(String key) {
    if (_preferences == null) return null;
    return _preferences!.getBool(key);
  }

  // Save an integer value
  Future<bool> saveInt(String key, int value) async {
    if (_preferences == null) await init();
    return _preferences!.setInt(key, value);
  }

  // Retrieve an integer value
  int? getInt(String key) {
    if (_preferences == null) return null;
    return _preferences!.getInt(key);
  }

  // Save a double value
  Future<bool> saveDouble(String key, double value) async {
    if (_preferences == null) await init();
    return _preferences!.setDouble(key, value);
  }

  // Retrieve a double value
  double? getDouble(String key) {
    if (_preferences == null) return null;
    return _preferences!.getDouble(key);
  }

  // Save a list of strings
  Future<bool> saveStringList(String key, List<String> value) async {
    if (_preferences == null) await init();
    return _preferences!.setStringList(key, value);
  }

  // Retrieve a list of strings
  List<String>? getStringList(String key) {
    if (_preferences == null) return null;
    return _preferences!.getStringList(key);
  }

  // Remove a specific key
  Future<bool> remove(String key) async {
    if (_preferences == null) await init();
    return _preferences!.remove(key);
  }

  // Clear all stored data
  Future<bool> clear() async {
    if (_preferences == null) await init();
    return _preferences!.clear();
  }
}