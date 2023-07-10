import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: size.width < 480
              ? EdgeInsets.fromLTRB(40, 320, 40, 300)
              : EdgeInsets.fromLTRB(120, 130, 120, 40),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                padding: size.width < 480
                    ? EdgeInsets.symmetric(horizontal: 10)
                    : EdgeInsets.symmetric(horizontal: 20),
                height: size.width < 480 ? size.height * .06 : size.height * .1,
                width: size.width < 480 ? size.width * .85 : size.width * .7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepPurple, width: 2)),
                child: TextField(
                  controller: _emailcontroller,
                  style: TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: mygreen),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: size.width < 480
                    ? EdgeInsets.symmetric(horizontal: 10)
                    : EdgeInsets.symmetric(horizontal: 20),
                height: size.width < 480 ? size.height * .06 : size.height * .1,
                width: size.width < 480 ? size.width * .85 : size.width * .7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.deepPurple, width: 2)),
                child: TextField(
                  controller: _passcontroller,
                  style: TextStyle(color: Colors.blue),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: mygreen),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
