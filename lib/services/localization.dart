import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocaleCont  {
  Locale locale = Locale('en', "US");
  updateLocale(Locale a) {
    locale = a;
  }
}

class AppLocalization {
  //Step 3
  late final Locale _locale;
  AppLocalization(this._locale);

//Step 4
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

//Step 5
  late Map<String, String> _localizedValues;

  Future loadLanguage() async {
    String jsonStringValues =
    await rootBundle.loadString("assets/lang/${_locale.languageCode}.json");
    Map<String, dynamic> mappedValues = json.decode(jsonStringValues);

    _localizedValues =
        mappedValues.map((key, value) => MapEntry(key, value.toString()));
  }

//Step 6
  String? getTranslatedValue(String key) {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
  _AppLocalizationDelegate();
}
class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization appLocalization = AppLocalization(locale);
    await appLocalization.loadLanguage();
    return appLocalization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
