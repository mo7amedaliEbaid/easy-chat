
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/global_constants.dart';
import '../../constants/texts.dart';
import '../../main.dart';
import '../screens/register_screen.dart';
class signinwithgoogle extends StatefulWidget {
  const signinwithgoogle({Key? key}) : super(key: key);

  @override
  State<signinwithgoogle> createState() => _signinwithgoogleState();
}

class _signinwithgoogleState extends State<signinwithgoogle> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future signInFunction() async {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      DocumentSnapshot userExist =
      await firestore.collection('users').doc(userCredential.user!.uid).get();

      if (userExist.exists) {
        // ignore: avoid_print
        print("User Already Exists in Database");
      } else {
        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'email': userCredential.user!.email,
          'name': userCredential.user!.displayName,
          'image': userCredential.user!.photoURL,
          'uid': userCredential.user!.uid,
          'date': DateTime.now(),
        });
      }

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyApp()),
              (route) => false);
    }
    return InkWell(
      onTap: ()async {
        await  signInFunction();

        // Navigator.of(context).push(_createRoute());
      },
      child:Row(
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
    /*  Container(
        margin: size.width < 480
            ? EdgeInsets.fromLTRB(0, 40, 0, 20)
            : EdgeInsets.fromLTRB(0, 40, 0, 20),
        height: size.width < 480 ? size.height * .08 : size.height * .15,
        width: size.width < 480 ? size.width * .7 : size.width * .3,
        decoration: BoxDecoration(
            color: lightgreen, borderRadius: BorderRadius.circular(20)),
        child: Center(child: registertext(context)),
      ),*/
    );
  }
}

/*
Widget signinwithgoogle(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  return InkWell(
    onTap: () {
      Navigator.of(context).push(_createRoute());
    },
    child: Container(
      margin: size.width < 480
          ? EdgeInsets.fromLTRB(0, 40, 0, 20)
          : EdgeInsets.fromLTRB(0, 40, 0, 20),
      height: size.width < 480 ? size.height * .08 : size.height * .15,
      width: size.width < 480 ? size.width * .7 : size.width * .3,
      decoration: BoxDecoration(
          color: lightgreen, borderRadius: BorderRadius.circular(20)),
      child: Center(child: registertext(context)),
    ),
  );
}
*/
