import 'package:chat_app/providers/navigationprovider.dart';

import '../screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import 'texts.dart';

Widget LoginButton(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  NavigationProvider navigationProvider = Provider.of(context, listen: false);
  return InkWell(
    onTap: () {
      Navigator.of(context).push(
          navigationProvider.createRoute(AuthScreen()));
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
      height: size.height * .08,
      width: size.width * .6,
      decoration: BoxDecoration(
          color: lightgreen, borderRadius: BorderRadius.circular(10)),
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/caht.png",height: 25,width: 25,fit: BoxFit.fill,),
          smallhorizontal_space,
          signwitheasytext(context),
        ],
      )),
    ),
  );
  // });
}
