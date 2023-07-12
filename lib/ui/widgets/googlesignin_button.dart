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
        height: size.height * .07,
        decoration: BoxDecoration(
            color: lightgreen, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/google.png',
              height: 25,
              width: 25,
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
