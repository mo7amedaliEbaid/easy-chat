import 'dart:async';
import 'dart:developer' as developer;
import 'package:chat_app/constants/app_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

import '../../constants/global_constants.dart';
import '../widgets/texts.dart';
import '../widgets/language_buttons.dart';
import '../widgets/login_button.dart';
import '../widgets/googlesignin_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool _isLoading = false;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose()async {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
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
  }
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
          : RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: _refresh,
              child: _connectionStatus != ConnectivityResult.none
                  ? buildonboard_body(context)
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
                    )),
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      _isLoading = false;
    });
  }
}

Widget buildonboard_body(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.width * .1, vertical: size.height * .1),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        welcometext(context),
        Lottie.asset(AppConstants.homelottie,
            height: size.height * .45, width: size.width * .85),
        vertical_space,
        signinwithgoogle(),
        vertical_space,
        LoginButton(context),
        LanguageButtons()
      ],
    ),
  );
}
