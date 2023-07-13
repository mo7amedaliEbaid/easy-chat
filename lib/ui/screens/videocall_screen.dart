import 'package:flutter/material.dart';

import 'joinchannelvideo.dart';
class VideocallsScreen extends StatelessWidget {
  const VideocallsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>JoinChannelVideo()));
        }, child: Text("go to video")),
      ),
    );
  }
}
