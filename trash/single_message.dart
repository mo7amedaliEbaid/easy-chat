/*
import 'package:flutter/material.dart';

import '../../models/user.dart';

class SingleMessage extends StatelessWidget {
  final UserModel currentUser;
  final String message;
  final bool isMe;
  final String time;
  final String image;

  const SingleMessage(
      {super.key,
        required this.message,
        required this.isMe,
        required this.time,
        required this.image,
        required this.currentUser,

      });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
              color: isMe ? Colors.black : Colors.orange,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          // child: Text(
          //   message,
          //   style: const TextStyle(
          //     color: Colors.white,
          //   ),
          // )
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(image: isMe ? NetworkImage(image):NetworkImage(currentUser.image))
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 0.0,
                    ),
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontSize: 5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
*/
