import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/message_model.dart';

class AuthProvider extends ChangeNotifier{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;
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


}