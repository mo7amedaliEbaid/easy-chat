
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user.dart';
import 'ui/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/locale_provider.dart';
import 'services/localization.dart';
import 'ui/screens/home.dart';
import 'ui/screens/onboarding_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "com.example.chat_app",
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<Widget> userSignedIn() async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        UserModel userModel = UserModel.fromJson(userData);
        return HomeScreen(userModel);
      } else {
        return const OnBoardingScreen();
      }
    }
    return Consumer<LocaleProvider>(builder: (context, localedata, _) {
      return MaterialApp(
        locale: localedata.locale,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalization.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('ar', 'EG'),
        ],
        /*localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale!.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },*/
        debugShowCheckedModeBanner: false,
        home:FutureBuilder(
            future: userSignedIn(),
            builder: (context, AsyncSnapshot<Widget> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!;
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            })); /* StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (ctx, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return OnBoardingScreen();
              }
              if (snapShot.hasData) {
                return ChatScreen();
              } else {
                return OnBoardingScreen();
              }
            }),
     //   OnBoardingScreen(),
      );*/
    });
  }
}
