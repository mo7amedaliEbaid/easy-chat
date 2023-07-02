import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/constants/texts.dart';
import 'package:chat_app/ui/widgets/language_buttons.dart';
import 'package:chat_app/ui/widgets/login_button.dart';
import 'package:chat_app/ui/widgets/register_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../services/localization.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scafold_background,
      body: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          if (constraints.maxWidth < 480) {
            return buildnormalonboard_body(context);
          } else {
            return buildwideonboard_body(context);
          }
        },
      ),
    );
  }
}

Widget buildnormalonboard_body(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width*.1, vertical: size.height*.1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        welcometext(context),
        Lottie.asset('assets/lottie/envelope.json'),
        RegisterButton(context),
        LoginButton(context),
       // LanguageButtons(),
      ],
    ),
  );
}

Widget buildwideonboard_body(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          welcometext(context),
          Lottie.asset('assets/lottie/envelope.json',width: size.width*.4,height: size.height*.6),
       //   LanguageButtons(),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RegisterButton(context),
          LoginButton(context),
        ],
      )
    ],
  );
}
