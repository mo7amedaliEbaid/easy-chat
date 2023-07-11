/*
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../providers/auth_provider.dart';

Widget okregister_button(BuildContext context,email,password ) {
  Size size = MediaQuery.sizeOf(context);
  return Consumer<AuthProvider>(builder: (context, authdata, _) {
    return InkWell(
      onTap: ()async{
        log("sssssssssssssssssssssssssssssss");
        await authdata.signUp(email: email, password: password);
      },
      child: Container(
        height: size.height * .07,
        width: size.width * .3,
        margin: EdgeInsets.only(top: size.height * .05),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: mygreen),
        child: Center(child: Text("Submit", style: normalwhite)),
      ),
    );
  });
}
*/
