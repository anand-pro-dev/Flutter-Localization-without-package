import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // To decode JSON
import 'package:flutter/services.dart'; // For loading assets

class LanguageProvider with ChangeNotifier {
  String _currentLanguage = 'en'; // Default language is English
  Map<String, String> _translations = {}; // To hold the loaded translations

  String get currentLanguage => _currentLanguage;
  Map<String, String> get translations => _translations;

  // Load language from SharedPreferences and load the corresponding JSON file
  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentLanguage =
        prefs.getString('language') ?? 'en'; // Default to English
    await _loadTranslations();
    notifyListeners();
  }


  // Set and save language to SharedPreferences, then load the corresponding JSON file
  Future<void> setLanguage(String languageCode) async {
    _currentLanguage = languageCode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);
    await _loadTranslations(); // Load translations for the new language
    notifyListeners();
  }


  // Load translations from JSON file based on the current language
  Future<void> _loadTranslations() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/$_currentLanguage.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _translations =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  
}
