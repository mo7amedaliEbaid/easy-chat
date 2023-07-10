
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';
import '../../constants/texts.dart';
import '../../providers/auth_provider.dart';
import '../screens/chating_screen.dart';

Widget LoginButton(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  return Consumer<AuthProvider>(builder: (context,authdata,_){
    return InkWell(
      onTap: ()async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChatingScreen()));
      },
      child: Container(
        margin: size.width < 480
            ? EdgeInsets.fromLTRB(0, 10, 0, 20)
            : EdgeInsets.fromLTRB(0, 20, 0, 20),
        height: size.width < 480 ? size.height * .08 : size.height * .15,
        width: size.width < 480 ? size.width * .7 : size.width * .3,
        decoration: BoxDecoration(
            color: lightgreen, borderRadius: BorderRadius.circular(20)),
        child: Center(child: logintext(context)),
      ),
    );
  });

}
