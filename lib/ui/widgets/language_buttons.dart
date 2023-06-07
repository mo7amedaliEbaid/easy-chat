import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constants.dart';
import '../../constants/global_constants.dart';
import '../../models/language_model.dart';
import '../../providers/locale_provider.dart';
import '../../services/localization.dart';

class LanguageButtons extends StatefulWidget {
  const LanguageButtons({Key? key}) : super(key: key);

  @override
  State<LanguageButtons> createState() => _LanguageButtonsState();
}

class _LanguageButtonsState extends State<LanguageButtons> {
  bool isarabicchosen = false;
  Locale _changeLanguage(Language language, context) {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: size.width < 480
            ? EdgeInsets.fromLTRB(30, 50, 30, 20)
            : EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: Consumer<LocaleProvider>(builder: (context, data, _) {
          return Row(
            children: [
              InkWell(
                onTap: () async{
                  setState(() {
                    isarabicchosen = false;
                    data.updateLocale(_changeLanguage(
                        Language.languageList().first, context));
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool("is_arabic",false);
                },
                child: Container(
                  height:
                      size.width < 480 ? size.height * .05 : size.height * .1,
                  width: size.width < 480 ? size.width * .25 : size.width * .15,
                  decoration: BoxDecoration(
                      color: !isarabicchosen ? chosencolor : unchosencolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      AppLocalization.of(context)
                          .getTranslatedValue("english")
                          .toString(),
                      style: normalwhite,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              InkWell(
                onTap: ()async {
                  setState(() {
                    isarabicchosen = true;
                    data.updateLocale(
                        _changeLanguage(Language.languageList().last, context));
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool("is_arabic",true);
                },
                child: Container(
                  height:
                      size.width < 480 ? size.height * .05 : size.height * .1,
                  width: size.width < 480 ? size.width * .25 : size.width * .15,
                  decoration: BoxDecoration(
                      color: isarabicchosen ? chosencolor : unchosencolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      AppLocalization.of(context)
                          .getTranslatedValue("arabic")
                          .toString(),
                      style: normalwhite,
                    ),
                  ),
                ),
              )
            ],
          );
        }));
  }
}
