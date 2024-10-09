import 'package:flutter/material.dart';
import 'package:flutter_mluti_language_provider/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LanguageProvider()..loadLanguage(), // Load saved language
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            home: HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final translations = languageProvider.translations;

    return Scaffold(
      appBar: AppBar(
        title: Text(translations['language'] ?? ''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(translations['hello'] ?? '', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text(translations['welcome'] ?? '', style: TextStyle(fontSize: 24)),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Toggle language between English and Somali
                String newLanguage =
                    languageProvider.currentLanguage == 'en' ? 'so' : 'en';
                languageProvider.setLanguage(newLanguage); // Save new language
              },
              child: Text(translations['change_language'] ?? ''),
            ),
          ],
        ),
      ),
    );
  }
}
