import 'package:chat_app/constants/global_constants.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: size.width < 480
              ? EdgeInsets.fromLTRB(40, 300, 40, 300)
              : EdgeInsets.fromLTRB(120, 120, 120, 40),
          child: Column(
            children: [
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
                  //  controller: controller,
                  style: TextStyle(color: Colors.blue),
                  decoration: InputDecoration(
                    hintText: "User Name",
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
