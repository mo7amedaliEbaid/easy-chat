import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale locale = Locale('en', "US");
  updateLocale(Locale a) {
    locale = a;
    notifyListeners();
  }
}