import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en', 'US');

  Locale get locale => _locale;

  void setLocale(Locale newLocale) {
    if (newLocale.languageCode != _locale.languageCode) {
      _locale = newLocale;
      notifyListeners();
    }
  }

  void setLocaleLanguageCode(String languageCode) {
    final newLocale = Locale(languageCode);
    setLocale(newLocale);
  }
}
