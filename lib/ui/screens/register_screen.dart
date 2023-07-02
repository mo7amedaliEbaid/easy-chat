import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../services/localization.dart';
import '../widgets/okregister_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passcontroller = TextEditingController();
  final GlobalKey<FormState> _registerformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: scafold_background,
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(builder: (context, authdata, _) {
          return Form(
            key: _registerformKey,
            child: Padding(
              padding: size.width < 480
                  ? EdgeInsets.symmetric(
                      vertical: size.height * .1, horizontal: size.width * .1)
                  : EdgeInsets.fromLTRB(120, 120, 120, 40),
              child: Column(
                children: [
                  Lottie.asset('assets/lottie/register.json',
                      height: size.height * .5),
                  /* Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: size.width < 480
                      ? EdgeInsets.symmetric(horizontal: 10)
                      : EdgeInsets.symmetric(horizontal: 20),
                  height: size.width < 480 ? size.height * .06 : size.height * .1,
                  width: size.width < 480 ? size.width * .85 : size.width * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple, width: 2)),
                  child: TextFormField(
                    //  controller: controller,
                    style: TextStyle(color: Colors.blue),
                    decoration: InputDecoration(
                      hintText: "User Name",
                      hintStyle: TextStyle(color: mygreen),
                      border: InputBorder.none,
                    ),
                  ),
                ),*/
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    padding: size.width < 480
                        ? EdgeInsets.symmetric(horizontal: 10)
                        : EdgeInsets.symmetric(horizontal: 20),
                    height:
                        size.width < 480 ? size.height * .06 : size.height * .1,
                    width:
                        size.width < 480 ? size.width * .85 : size.width * .7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepPurple, width: 2)),
                    child: TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalization.of(context)
                              .getTranslatedValue("emailvalidate")
                              .toString();
                        }
                        return null;
                      },
                      controller: _emailcontroller,
                      style: TextStyle(color: Colors.blue),
                      decoration: InputDecoration(
                        // helperText: "yyyyy",
                        prefixText: "Email          ",
                        hintText: "Email",
                        prefixStyle: TextStyle(color: mygreen),
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
                    height:
                        size.width < 480 ? size.height * .06 : size.height * .1,
                    width:
                        size.width < 480 ? size.width * .85 : size.width * .7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.deepPurple, width: 2)),
                    child: TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return AppLocalization.of(context)
                              .getTranslatedValue("pass_validate")
                              .toString();
                        }
                        return null;
                      },
                      controller: _passcontroller,
                      style: TextStyle(color: Colors.blue),
                      obscureText: false,
                      decoration: InputDecoration(
                        prefixText: "Password  ",
                        hintText: "Password",
                        prefixStyle: TextStyle(color: mygreen),
                        hintStyle: TextStyle(color: mygreen),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  okregister_button(
                      context,
                      _emailcontroller.text.toString().trim(),
                      _passcontroller.text.toString().trim())
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
