import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';

Widget RegisterButton(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return InkWell(
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 50, 0, 20),
      height: size.height * .08,
      width: size.width * .7,
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
