import 'package:chat_app/providers/auth_provider.dart';
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
    AuthProvider authProvider=Provider.of<AuthProvider>(context,listen: false);

    return InkWell(
      onTap: () async {
        await authProvider.signInFunction(context);
        },
      child: Container(
        width: size.width * .55,
        height: size.height * .07,
        decoration: BoxDecoration(
            color: lightgreen, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
              height: 36,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Sign in With Google",
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

