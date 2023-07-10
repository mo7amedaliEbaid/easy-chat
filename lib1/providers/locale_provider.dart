import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../models/language_model.dart';

class LocaleProvider extends ChangeNotifier {
  Future<Locale> getlocale()async{
    SharedPreferences prefs =
        await SharedPreferences.getInstance();
    bool? isarabic = prefs.getBool('is_arabic');
    log("is arabic=${isarabic}");
    if(isarabic==null){
      return Locale('en', "US");
    }else if(isarabic==true){
     return Locale('ar', 'EG');
    }else{
      return Locale('en', "US");
    }
  }
  Locale changeLanguage(Language language, context) {
    Locale _a;
    switch (language.languageCode) {
      case AppConstants.ENGLISH:
        _a = Locale(language.languageCode, "US");

        break;
      case AppConstants.Arabic:
        _a = Locale(language.languageCode, "EG");

        break;

      default:
        _a = Locale(language.languageCode, 'US');
    }
    return _a;
  }
  Locale locale =Locale('en', "US");
  //Locale locale = Locale('ar', 'EG');//Locale('en', "US");
  updateLocale(Locale a) {
    locale = a;
    notifyListeners();
  }
}