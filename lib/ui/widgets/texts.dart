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
Widget creategrouptext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("creategroup")
        .toString(),
     style: normalwhite,
  );
}
Widget searchtext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("search")
        .toString(),
    // style: smallgreenstyle,
  );
}
Widget chatstext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("chats")
        .toString(),
    // style: smallgreenstyle,
  );
}
Widget groupstext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("groups")
        .toString(),
   // style: smallgreenstyle,
  );
}
Widget videocallstext(BuildContext context){
  return Text(
    AppLocalization.of(context)
        .getTranslatedValue("videocalls")
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
