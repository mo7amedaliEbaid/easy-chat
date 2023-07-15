import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';
import 'image_message.dart';

Widget message_bubble(Size size, Map<String, dynamic> map, BuildContext context,
    Map<String, dynamic> userMap) {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  return map['type'] == "text"
      ? Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          // width: size.width * .7,
          alignment: map['sendby'] == _auth.currentUser!.displayName
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment:
                    map['sendby'] == _auth.currentUser!.displayName
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                children: [
                  Container(
                    // height: size.height * .1,
                    width: size.width * .5,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    margin: map['sendby'] == _auth.currentUser!.displayName
                        ? EdgeInsets.fromLTRB(25, 34, 0, 0)
                        : EdgeInsets.fromLTRB(0, 34, 25, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        topRight: Radius.circular(14),
                        bottomLeft:
                            map['sendby'] == _auth.currentUser!.displayName
                                ? Radius.circular(0)
                                : Radius.circular(14),
                        bottomRight:
                            map['sendby'] == _auth.currentUser!.displayName
                                ? Radius.circular(14)
                                : Radius.circular(0),
                      ),
                      color: lightgreen,
                    ),
                    child:
                        Center(child: Text(map['message'], style: normalwhite)),
                  ),
                ],
              ),
              map['sendby'] == _auth.currentUser!.displayName
                  ? Positioned(
                      top: 10,
                      left: 0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(userMap['image']),
                      ),
                    )
                  : Positioned(
                      top: 10,
                      right: 0,
                      child: CircleAvatar(
                        backgroundImage:NetworkImage(userMap['image']),
                      ),
                    ),
            ],
          ),
        )
      : Container(
          height: size.height / 2.5,
          width: size.width,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          alignment: map['sendby'] == _auth.currentUser!.displayName
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ShowImage(
                    imageUrl: map['message'],
                    ismine: map['sendby'] == _auth.currentUser!.displayName
                        ? true
                        : false),
              ),
            ),
            child: Container(
              height: size.height / 2.5,
              width: size.width / 2,
              decoration: BoxDecoration(border: Border.all()),
              alignment: map['message'] != "" ? null : Alignment.center,
              child: map['message'] != ""
                  ? Image.network(
                      map['message'],
                      fit: BoxFit.cover,
                    )
                  : CircularProgressIndicator(),
            ),
          ),
        );
}
