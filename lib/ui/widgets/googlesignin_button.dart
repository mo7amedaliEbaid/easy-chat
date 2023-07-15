import 'package:chat_app/constants/app_constants.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/global_constants.dart';

class signinwithgoogle extends StatefulWidget {
  const signinwithgoogle({Key? key}) : super(key: key);

  @override
  State<signinwithgoogle> createState() => _signinwithgoogleState();
}

class _signinwithgoogleState extends State<signinwithgoogle> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);

    return InkWell(
      onTap: () async {
        await authProvider.signInFunction(context);
      },
      child: Container(
        width: size.width * .6,
        height: size.height * .05,
        decoration: BoxDecoration(
            color: lightgreen, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              AppConstants.google_icon,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            smallhorizontal_space,
            signgoogletext(context)
          ],
        ),
      ),
    );
  }
}
