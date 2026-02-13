import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

/// Base class for the generated app localizations.
abstract class AppLocalizations {
  String get appTitle;
  String get welcome;
  String get login;
  String get signup;
  String get email;
  String get password;
  String get forgotPassword;
  String get rememberMe;
  String get logout;
  String get settings;
  String get language;
  String get english;
  String get french;
  String get spanish;
  String get notifications;
  String get profile;
  String get home;
  String get cart;
  String get favorites;
  String get products;
  String get search;
  String get loading;
  String get error;
  String get success;
  String get cancel;
  String get save;
  String get delete;
  String get edit;
  String get add;
  String get price;
  String get quantity;
  String get addToCart;
  String get checkout;
  String get confirmDelete;
  String get noResults;

  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return _load(locale);
  }

  @override
  bool isSupported(Locale locale) => supportedLanguageCodes.contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;

  static Future<AppLocalizations> _load(Locale locale) async {
    final canonicalized = intl.Intl.canonicalizedLocale(locale.toString());
    final isoCode = intl.Intl.parseCompactLocale(canonicalized);

    if (isoCode == 'fr') {
      return AppLocalizationsFr(canonicalized);
    } else if (isoCode == 'es') {
      return AppLocalizationsEs(canonicalized);
    }

    return AppLocalizationsEn(canonicalized);
  }
}

const supportedLanguageCodes = ['en', 'fr', 'es'];
