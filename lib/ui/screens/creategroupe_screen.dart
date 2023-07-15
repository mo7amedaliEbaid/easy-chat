import 'package:chat_app/constants/app_constants.dart';
import 'package:chat_app/ui/screens/grouphome_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uuid/uuid.dart';

import '../../constants/global_constants.dart';

class CreateGroup extends StatefulWidget {
  final List<Map<String, dynamic>> membersList;

  const CreateGroup({required this.membersList, Key? key}) : super(key: key);

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final TextEditingController _groupName = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void createGroup() async {
    setState(() {
      isLoading = true;
    });

    String groupId = Uuid().v1();

    await _firestore.collection('groups').doc(groupId).set({
      "members": widget.membersList,
      "id": groupId,
    });

    for (int i = 0; i < widget.membersList.length; i++) {
      String uid = widget.membersList[i]['uid'];

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('groups')
          .doc(groupId)
          .set({
        "name": _groupName.text,
        "id": groupId,
      });
    }

    await _firestore.collection('groups').doc(groupId).collection('chats').add({
      "message": "${_auth.currentUser!.displayName} Created This Group.",
      "type": "notify",
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => GroupChatHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: scafold_background,
        appBar: AppBar(
          backgroundColor: mygreen,
          title: Text("Create Group"),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppConstants.background_image),
                  fit: BoxFit.fill)),
          child: isLoading
              ? Container(
                  height: size.height,
                  width: size.width,
                  alignment: Alignment.center,
                  child: SpinKitHourGlass(
                    color: mygreen,
                    size: 75,
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: size.height / 10,
                    ),
                    Container(
                      height: size.height / 14,
                      width: size.width,
                      alignment: Alignment.center,
                      child: Container(
                        height: size.height / 14,
                        width: size.width / 1.15,
                        child: TextField(
                          controller: _groupName,
                          decoration: InputDecoration(
                            hintText: "Enter Group Name",
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
                    SizedBox(
                      height: size.height / 50,
                    ),
                    ElevatedButton(
                      style: elevatedstyle,
                      onPressed: createGroup,
                      child: Text("Create Group"),
                    ),
                  ],
                ),
        ));
  }
}
