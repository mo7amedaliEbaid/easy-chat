import 'dart:io';

import 'package:chat_app/constants/app_constants.dart';
import 'package:chat_app/constants/global_constants.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import '../../services/localization.dart';
import 'user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,
      File image, bool isLogin, BuildContext ctx) submitFn;

  AuthForm(this.submitFn);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = "";
  String _password = "";
  String _username = "";
  File? _userImageFile;

  void _pickedImage(File pickedImage) {
    _userImageFile = pickedImage;
  }

  void _submit(BuildContext context) {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (!_isLogin && _userImageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please pick an image."),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid != null) {
      _formKey.currentState?.save();
      widget.submitFn(
          _email.trim(),
          _password.trim(),
          _username.trim(),
          _userImageFile ?? File(AppConstants.error_image),
          _isLogin,
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: lightgreen,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Consumer<AuthProvider>(builder: (context, authdata, _) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagePicker(_pickedImage),
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      autocorrect: false,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.none,
                      key: ValueKey('email'),
                      validator: (val) {
                        if (val!.isEmpty || !val.contains('@')) {
                          return AppLocalization.of(context)
                              .getTranslatedValue("pass_validate")
                              .toString();
                        }
                        return null;
                      },
                      onSaved: (val) => _email = val!,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context)
                            .getTranslatedValue("email")
                            .toString(),
                      ),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        autocorrect: true,
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.words,
                        key: ValueKey('username'),
                        validator: (val) {
                          if (val!.isEmpty || val.length < 4) {
                            return AppLocalization.of(context)
                                .getTranslatedValue("pass_validate")
                                .toString();
                          }
                          return null;
                        },
                        onSaved: (val) => _username = val!,
                        decoration: InputDecoration(
                          labelText: AppLocalization.of(context)
                              .getTranslatedValue("username")
                              .toString(),
                        ),
                      ),
                    TextFormField(
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      key: ValueKey('password'),
                      validator: (val) {
                        if (val!.isEmpty || val.length < 7) {
                          return AppLocalization.of(context)
                              .getTranslatedValue("pass_validate")
                              .toString();
                        }
                        return null;
                      },
                      onSaved: (val) => _password = val!,
                      decoration: InputDecoration(
                        labelText: AppLocalization.of(context)
                            .getTranslatedValue("password")
                            .toString(),
                      ),
                      obscureText: true,
                    ),
                    vertical_space,
                    if (authdata.isloading)
                      SpinKitHourGlass(
                        color: mygreen,
                        size: 70,
                      ),
                    if (!authdata.isloading)
                      ElevatedButton(
                          style: elevatedstyle,
                          child: _isLogin
                              ? logintext(context)
                              : signuptext(context),
                          onPressed: () {
                            _submit(context);
                          }),
                    if (!authdata.isloading)
                      TextButton(
                        child: _isLogin
                            ? createaccounttext(context)
                            : alradyhaveaccounttext(context),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                      ),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
