import 'package:chat_app/constants/app_constants.dart';
import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/services/message_services.dart';
import 'package:chat_app/ui/widgets/texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../services/localization.dart';
import 'chatroom_screen.dart';

class ChatsScreen extends StatefulWidget {
  @override
  _ChatsScreenState createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> with WidgetsBindingObserver {
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
      setStatus("Online");
    } else {
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
        title: chatstext(context),
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
                          hintText: AppLocalization.of(context)
                              .getTranslatedValue("searchbyemail")
                              .toString(),
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
                    child: searchtext(context),
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
