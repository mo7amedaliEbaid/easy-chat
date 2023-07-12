import 'package:flutter/material.dart';

import '../../services/localization.dart';
import '../../constants/global_constants.dart';
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
Widget signwitheasytext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("signwitheasy")
        .toString(),
    style: normalwhite,
  );
}
Widget signgoogletext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("signwithgoogle")
        .toString(),
    style: normalwhite,
  );
}
Widget logintext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("login")
        .toString(),
    style: normalwhite,
  );
}
Widget createaccounttext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("createaccount")
        .toString(),
    style: smallgreenstyle,
  );
}
Widget emailtext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("email")
        .toString(),
    // style: smallgreenstyle,
  );
}
Widget passtext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("password")
        .toString(),
    // style: smallgreenstyle,
  );
}
Widget usernametext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("username")
        .toString(),
    // style: smallgreenstyle,
  );
}
Widget validateemailtext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("emailvalidate")
        .toString(),
   // style: smallgreenstyle,
  );
}
Widget validatepasstext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("pass_validate")
        .toString(),
    // style: smallgreenstyle,
  );

}
Widget signuptext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("signup")
        .toString(),
     style: normalwhite,
  );

}
Widget alradyhaveaccounttext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("alreadyhaveaccount")
        .toString(),
     style: smallgreenstyle,
  );

}
