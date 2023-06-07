import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/ui/widgets/login_button.dart';
import 'package:chat_app/ui/widgets/register_button.dart';
import 'package:flutter/material.dart';

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
    padding: EdgeInsets.symmetric(horizontal: 58.0, vertical: 200),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Welcome To Easy Chat",
          style: greenstyle,
        ),
        RegisterButton(context),
        LoginButton(context),
      ],
    ),
  );
}

Widget buildwidehomebody(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 200.0, vertical: 20),
    child: Row(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Welcome To Easy Chat",
          style: greenstyle,
        ),
        Column(
          children: [
            RegisterButton(context),
            LoginButton(context),
          ],
        )
      ],
    ),
  );
}
