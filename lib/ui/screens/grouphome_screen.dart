
import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/widgets/animated_route.dart';
import 'package:chat_app/ui/widgets/texts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'choosegroupmembers_screen.dart';
import 'groupchatroom_screen.dart';

class GroupChatHomeScreen extends StatefulWidget {
  const GroupChatHomeScreen({Key? key}) : super(key: key);

  @override
  _GroupChatHomeScreenState createState() => _GroupChatHomeScreenState();
}

class _GroupChatHomeScreenState extends State<GroupChatHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
   bool _isLoading = true;
   List groupList = [];

  @override
  void initState() {
   getAvailableGroups();
    super.initState();
  }

  void getAvailableGroups() async {
    String uid = _auth.currentUser!.uid;

    await _firestore
        .collection('users')
        .doc(uid)
        .collection('groups')
        .get()
        .then((value) {
      setState(() {
        groupList = value.docs;
        _isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    AuthProvider authProvider=Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      backgroundColor: scafold_background,
      appBar: AppBar(
        backgroundColor: mygreen,
        title: groupstext(context),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authProvider.logOut(context);
              })
        ],
      ),
      body:  _isLoading
            ? Container(
                height: size.height,
                width: size.width,
                alignment: Alignment.center,
                child: SpinKitHourGlass(
                  color: mygreen,
                  size: 75,
                ),
              )
            : groupList.length == 0
                ? Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                   "You Don\'t have any groups!",
                  style: greenstyle,
                ),
                vertical_space,
                vertical_space,
                vertical_space,
                ElevatedButton(
                    style: elevatedstyle,
                    onPressed: () => Navigator.of(context).push(
                      createRoute(ChoosegroupmembersScreen())
                ), child: creategrouptext(context))
              ],
            ),
          ),
        )
                : ListView.builder(
                    itemCount: groupList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => GroupChatRoom(
                              groupName: groupList[index]['name'],
                              groupChatId: groupList[index]['id'],
                            ),
                          ),
                        ),
                        leading: Icon(Icons.group,size: 50,color: mygreen,),
                        title: Text(groupList[index]['name'],style: normalgreenstyle,),
                      );
                    },
                  ),

    );
  }
}



