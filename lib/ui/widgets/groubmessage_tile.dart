import 'package:chat_app/constants/global_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
Widget messageTile(Size size, Map<String, dynamic> chatMap) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return Builder(builder: (_) {
    if (chatMap['type'] == "text") {
      return Container(
        width: size.width,
        alignment: chatMap['sendBy'] == _auth.currentUser!.displayName
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: mygreen,
            ),
            child: Column(
              children: [
                Text(
                  chatMap['sendBy'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(
                  height: size.height / 200,
                ),
                Text(
                  chatMap['message'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            )),
      );
    } else if (chatMap['type'] == "img") {
      return Container(
        width: size.width,
        alignment: chatMap['sendBy'] == _auth.currentUser!.displayName
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          height: size.height / 2,
          child: Image.network(
            chatMap['message'],
          ),
        ),
      );
    } else if (chatMap['type'] == "notify") {
      return Container(
        width: size.width,
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black38,
          ),
          child: Text(
            chatMap['message'],
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return SizedBox();
    }
  });
}