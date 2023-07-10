
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
import 'ui/screens/chating_screen.dart';
import 'ui/screens/onboarding_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "com.example.chat_app",
      options: DefaultFirebaseOptions.currentPlatform
   // options:  DefaultFirebaseOptions.currentPlatform,
    /*FirebaseOptions(
      apiKey: "AIzaSyALkiNMpJD-PVevrs7nuFck1HMkNtS00Bc",
      appId: "1:966826657989:android:bb27d7664a792f8adcc8ac",
      messagingSenderId: "966826657989-6obk3tkvg0c31ettroca1hsr66c9m2io.apps.googleusercontent.com",
      projectId: "easy-chat-84b64",
    ),*/
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
        home:  StreamBuilder(
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
      );
    });
  }
}
