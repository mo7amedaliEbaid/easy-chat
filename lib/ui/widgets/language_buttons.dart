import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/global_constants.dart';
import '../../models/language_model.dart';
import '../../providers/locale_provider.dart';

class LanguageButtons extends StatefulWidget {
  const LanguageButtons({Key? key}) : super(key: key);

  @override
  State<LanguageButtons> createState() => _LanguageButtonsState();
}

class _LanguageButtonsState extends State<LanguageButtons> {
  bool isarabicchosen = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Consumer<LocaleProvider>(builder: (context, data, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async{
                  setState(() {
                    isarabicchosen = false;
                    data.updateLocale(data.changeLanguage(
                        Language
                            .languageList()
                            .first, context));
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool("is_arabic",false);
                },
                child: Container(
                  height:
                     size.height * .05 ,
                  width: size.width * .25,
                  decoration: BoxDecoration(
                      color: !isarabicchosen ? chosencolor : unchosencolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "English",
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
                    data.updateLocale(data.changeLanguage(
                        Language
                            .languageList()
                            .last, context));
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool("is_arabic",true);
                },
                child: Container(
                  height:
                      size.height * .05,
                  width: size.width * .25 ,
                  decoration: BoxDecoration(
                      color: isarabicchosen ? chosencolor : unchosencolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "العربية",
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
