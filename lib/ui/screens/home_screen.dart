import 'package:chat_app/constants/global_constants.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: scafold_background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Welcome To Easy Chat",style: greenstyle,),
          InkWell(
            child: Container(
             decoration: BoxDecoration(
               color: lightgreen,

             ),
            ),
          )
        ],
      ),
    );
  }
}
