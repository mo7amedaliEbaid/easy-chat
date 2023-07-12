
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/global_constants.dart';
import '../../models/user.dart';
import 'chat_screen.dart';
import 'groupchat.dart';
import 'onboarding_screen.dart';

class MainScreen extends StatefulWidget {
  UserModel user;
  MainScreen(this.user, {super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String name = "";
  List<Map> searchResult = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Map<String, dynamic> userMap;
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
      backgroundColor: scafold_background,
        appBar: AppBar(
          backgroundColor: mygreen,
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
            ],
            title: Card(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search,color: mygreen,), hintText: 'Search...'),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            )),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('name', isNotEqualTo: widget.user.name)
              .snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
              child:  SpinKitHourGlass(
                color: mygreen,
                size: 70,
              ),
            )
                : ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  var data = snapshots.data!.docs[index].data()
                  as Map<String, dynamic>;
                  if (name.isEmpty) {
                    return ListTile(
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['image']??""),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            String roomId = chatRoomId(
                                _auth.currentUser!.displayName!,
                                data['name']);
                            log("roomid=$roomId");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatRoom(
                                       currentUser: widget.user,
                                        friendId: data['uid'],
                                        friendName: data['name'],
                                        friendImage: data['image'],
                                      chatRoomId: roomId,
                                    )));
                          },
                          icon: const Icon(Icons.message)),
                    );
                  }
                  if (data['name']
                      .toString()
                      .toLowerCase()
                      .startsWith(name.toLowerCase())) {
                    return ListTile(
                      title: Text(
                        data['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data['image']),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            String roomId = chatRoomId(
                                _auth.currentUser!.displayName!,
                                data['name']);
                            log("roomid=$roomId");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatRoom(
                                        currentUser: widget.user,
                                        friendId: data[index]['uid'],
                                        friendName: data[index]['name'],
                                        friendImage: data[index]
                                        ['image'],
                                //    userMap: {},
                                    chatRoomId: roomId,)));
                          },
                          icon: const Icon(Icons.message)),
                    );
                  }
                  return Container();
                });
          },
        ));
  }
}