import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/ui/widgets/language_buttons.dart';
import 'package:chat_app/ui/widgets/login_button.dart';
import 'package:chat_app/ui/widgets/register_button.dart';
import 'package:flutter/material.dart';

import '../../services/localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scafold_background,
      body: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          if (constraints.maxWidth < 480) {
            return buildnormalhomebody(context);
          } else {
            return buildwidehomebody(context);
          }
        },
      ),
    );
  }
}

Widget buildnormalhomebody(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 58.0, vertical: 150),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppLocalization.of(context)
              .getTranslatedValue("welcome")
              .toString(),
          style: greenstyle,
        ),
        RegisterButton(context),
        LoginButton(context),
        LanguageButtons(),
      ],
    ),
  );
}

Widget buildwidehomebody(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalization.of(context)
                .getTranslatedValue("welcome")
                .toString(),
            style: greenstyle,
          ),
          LanguageButtons(),
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
