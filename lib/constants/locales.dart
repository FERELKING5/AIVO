import 'package:flutter/material.dart';

class AppLocales {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('fr', 'FR'),
    Locale('es', 'ES'),
  ];

  static const Locale fallbackLocale = Locale('en', 'US');

  static String getLanguageName(String languageCode) {
    switch (languageCode) {
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      case 'en':
      default:
        return 'English';
    }
  }
}
