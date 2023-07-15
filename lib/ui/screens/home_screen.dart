import 'package:chat_app/constants/app_constants.dart';
import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/services/message_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final MessageServices messageServices = MessageServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // online
      setStatus("Online");
    } else {
      // offline
      setStatus("Offline");
    }
  }


  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("email", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        isLoading = false;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: scafold_background,
      appBar: AppBar(
        backgroundColor: mygreen,
        title: Text("Chats"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authProvider.logOut(context);
              })
        ],
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: SpinKitHourGlass(
                  color: mygreen,
                  size: 70,
                ),
              ),
            )
           : SingleChildScrollView(
             child: Column(
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    height: size.height / 14,
                    width: size.width,
                    alignment: Alignment.center,
                    child: Container(
                      height: size.height / 14,
                      width: size.width / 1.15,
                      child: TextField(
                        onTapOutside: (event) => FocusScope.of(context).unfocus(),
                        controller: _search,
                        decoration: InputDecoration(
                          hintText: "Search by email",
                          hintStyle: normalwhite,
                          filled: true,
                          fillColor: lightgreen,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  vertical_space,
                  vertical_space,
                  ElevatedButton(
                    onPressed: onSearch,
                    child: Text("Search"),
                    style: elevatedstyle,
                  ),
                  vertical_space,
                  vertical_space,
                  vertical_space,
                  userMap != null
                      ? Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: lightgreen,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        
                        child: ListTile(
                          onTap: () {
                              String roomId = messageServices.chatRoomId(
                                  _auth.currentUser!.displayName!,
                                  userMap!['name']);

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ChatRoom(
                                    chatRoomId: roomId,
                                    userMap: userMap!,
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              radius: 35,
                              backgroundImage:NetworkImage(userMap!['image']),
                            ),
                            title: Text(
                              userMap!['name'],
                              style: normalgreenstyle
                            ),
                            subtitle: Text(userMap!['email'],style: smallgreenstyle,),
                            trailing: Icon(Icons.chat, color: mygreen),
                          ),
                      )
                      : Container(
                          child: Lottie.asset(AppConstants.homelottie,
                              height: size.height * .5),
                        ),
                ],
              ),
           ),
    );
  }
}
/*

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../constants/global_constants.dart';
import '../../models/user.dart';
import 'chat_screen.dart';
import 'grouphome_screen.dart';
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
}*/
