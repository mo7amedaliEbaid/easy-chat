import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';

Widget RegisterButton(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return InkWell(
    child: Container(
      margin: size.width < 480
          ? EdgeInsets.fromLTRB(0, 50, 0, 20)
          : EdgeInsets.fromLTRB(0, 50, 0, 20),
      height: size.width < 480 ? size.height * .08 : size.height * .15,
      width: size.width < 480 ? size.width * .7 : size.width * .3,
      decoration: BoxDecoration(
          color: lightgreen, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: Text(
        "Register",
        style: bigwhite,
      )),
    ),
  );
}
