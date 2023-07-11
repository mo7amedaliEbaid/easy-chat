// ignore_for_file: must_be_immutable, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../models/user.dart';
import 'chat_screen.dart';
import 'groupchat.dart';
import 'hs.dart';
import 'onboarding_screen.dart';

class HomeScreen extends StatefulWidget {
  UserModel user;

  HomeScreen(this.user, {super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () async {
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnBoardingScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.logout)),
          IconButton(onPressed: (){
          /*  Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatRoom(chatRoomId: chatRoomId, userMap: userMap),
              ),
            );*/
          }, icon: Icon(Icons.group))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.user.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return const Center(
                  child: Text("No Chats Available !"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendId = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];
                     var date = snapshot.data.docs[index]['date'];
                    var a = DateTime.parse(
                        snapshot.data.docs[index]['date'].toDate().toString());
                    var time = DateFormat(' hh:mm a').format(a);

                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                margin: const EdgeInsets.only(),
                                width: 58.0,
                                height: 65.0,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    friend['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              friend['name'],
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // ignore: avoid_unnecessary_containers
                            subtitle: Container(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "$lastMsg",
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 200.0,
                                    ),
                                    child: Text(
                                      time,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              // child: Text(
                              //   "$lastMsg",
                              //   style: const TextStyle(color: Colors.grey),
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                            ),
                            onTap: () {
                              String roomId = chatRoomId(
                                  _auth.currentUser!.displayName!,
                                  friend['name']);
                              log("roomid=$roomId");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatRoom(
                                          currentUser: widget.user,
                                          friendId: friend['uid'],
                                          friendName: friend['name'],
                                          friendImage: friend['image'],
                                     // userMap: {},
                                      chatRoomId:roomId,)));
                            },
                          );
                        }
                        return const LinearProgressIndicator();
                      },
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainScreen(widget.user)));
          // MaterialPageRoute(
          //     builder: (context) => SearchScreen(widget.user)));
        },
      ),
    );
  }
}
