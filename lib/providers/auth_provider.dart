import 'dart:developer';
import 'package:chat_app/ui/screens/main_screen.dart';
import 'package:chat_app/ui/screens/root_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import '../main.dart';
import '../models/message_model.dart';
import '../models/user.dart';
import '../ui/screens/onboarding_screen.dart';

class AuthProvider extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isloading = false;

 /* changeswitch_text(){
    isloading=!isloading;
  }*/
  Future signInFunction(BuildContext context) async {
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    DocumentSnapshot userExist = await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();

    if (userExist.exists) {
      // ignore: avoid_print
      print("User Already Exists in Database");
    } else {
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
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
  Future<Widget> userSignedIn() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      UserModel userModel = UserModel.fromJson(userData);
      return RootScreen( index: 0, userModel: userModel,);
    } else {
      return const OnBoardingScreen();
    }
  }
  void submitAuthForm(String email, String password, String username,
      File image, bool isLogin, BuildContext context) async {
    UserCredential authResult;

    try {
   //   setState(() {
        isloading = true;
   //   });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        _firestore
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .get()
            .then((value){ authResult.user!.updateDisplayName(value['name']);
        authResult.user!.updatePhotoURL(value['image']);
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
                (route) => false);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final ref = FirebaseStorage.instance
            .ref()
            .child('image')
            .child(authResult.user!.uid + '.jpg');

        await ref.putFile(image);


        final url = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user?.uid)
            .set({
          'email': email,
          'uid': authResult.user!.uid ,
          'date': DateTime.now(),
          'name': username,
          // 'password': password,
          'image': url,
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MyApp()),
                (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      String message = "error Occurred";

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ));
      isloading = false;

      /*setState(() {
        _isLoading = false;
      });*/
    } catch (e) {
      print(e);
      isloading = false;

      /*  setState(() {
        _isLoading = false;
      });*/
    }
  }
 /* get user => _auth.currentUser;
  //SIGN UP METHOD
  Future signUp({required String email, required String password}) async {
    try {
      var userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user !=null) {
        log("trueeeeeeeeeeeeeeeeeeeeeeeeeeeee");
        return "true";
      }
    } on FirebaseAuthException catch (e) {
      log("errorrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(user != null) {
        log("llllllllllllllllllllllllllllllllll$email");
        log("uuuuuuuuuuuuuuuuuussssssssssssseeeeeeeeeeeeeeerrrrrrrrrrrrrrrr$user");
        return "Welcome";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }
  List<Message> messages=[];
*/

}