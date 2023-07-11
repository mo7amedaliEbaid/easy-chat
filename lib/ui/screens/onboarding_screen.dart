import 'dart:async';
import 'dart:developer' as developer;
import 'auth_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../constants/global_constants.dart';
import '../../constants/texts.dart';
import '../../services/localization.dart';
import '../widgets/language_buttons.dart';
import '../widgets/login_button.dart';
import '../widgets/googlesignin_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _isLoading = false;

/*  @override
  void dispose() async {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      //  developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scafold_background,
      body: _isLoading
          ? Center(
              child: SpinKitHourGlass(
                color: mygreen,
                size: 70,
              ),
            )
          : /*RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: _refresh,
              child:*/
          buildnormalonboard_body(
              context) /*_connectionStatus == ConnectivityResult.none
                  ? LayoutBuilder(
                      builder: (BuildContext ctx, BoxConstraints constraints) {
                        if (constraints.maxWidth < 480) {
                          return buildnormalonboard_body(context);
                        } else {
                          return buildwideonboard_body(context);
                        }
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Lottie.asset("assets/lottie/lost-connection.json"),
                        InkWell(
                          onTap: () {
                            setState(() {
                              refreshIndicatorKey.currentState?.show();
                            });
                          },
                          child: Text("Try Again",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      decoration: TextDecoration.underline)),
                        )
                      ],
                    ))*/
      ,
    );
  }

/*  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _isLoading = false;
    });
  }*/
}

Widget buildnormalonboard_body(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.width * .1, vertical: size.height * .1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        welcometext(context),
        Lottie.asset('assets/lottie/online-chat.json',
            height: size.height * .45, width: size.width * .85),
        Expanded(child: signinwithgoogle()),
        LoginButton(context),
        Expanded(child: LanguageButtons()),
      ],
    ),
  );
}

/*Widget buildwideonboard_body(BuildContext context) {
  Size size = MediaQuery.sizeOf(context);
  developer.log(size.width.toString());
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          welcometext(context),
          Lottie.asset('assets/lottie/envelope.json',
              width: size.width * .4, height: size.height * .6),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         // RegisterButton(context),
          LanguageButtons(),
SizedBox(
  height:size.height*.1 ,
),
          LoginButton(context),
        ],
      )
    ],
  );
}*/
