import 'package:flutter/material.dart';

import '../services/localization.dart';
import 'global_constants.dart';
Widget welcometext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("welcome")
        .toString(),
    style: greenstyle,
  );
}

Widget registertext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("register")
        .toString(),
    style: bigwhite,
  );
}
Widget logintext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("login")
        .toString(),
    style: bigwhite,
  );
}