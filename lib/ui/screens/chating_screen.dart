import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ChatingScreen extends StatefulWidget {
  const ChatingScreen({Key? key}) : super(key: key);

  @override
  State<ChatingScreen> createState() => _ChatingScreenState();
}

class _ChatingScreenState extends State<ChatingScreen> {
  TextEditingController _controller=TextEditingController();
  final Stream<QuerySnapshot> _messagesstream =
  FirebaseFirestore.instance.collection('messages').snapshots();

  @override
  Widget build(BuildContext context) {
    CollectionReference messages = FirebaseFirestore.instance.collection('messages');

    Future<void> sendmessage() {
      // Call the user's CollectionReference to add a new user
      return messages
          .add({
        'message': _controller.text.toString(), // John Doe
      })
          .then((value) => print("message send"))
          .catchError((error) => print("Failed to send message: $error"));
    }

    return  Scaffold(
      body: Container(
        width: 400,
        height: 700,
        child: ListView(
          shrinkWrap: true,
          children:[
            TextField(
              controller: _controller,
            ),
            TextButton(
              onPressed: sendmessage,
              child: Text(
                "send message",
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _messagesstream,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Container(
                  height: 400,
                  width: 400,
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['message']),
                      //  subtitle: Text(data['company']),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ]
          ),
      ),

    );
  }
}
