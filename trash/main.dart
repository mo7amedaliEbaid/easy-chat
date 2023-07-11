/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../lib1/ui/screens/googleauth_screen.dart';
import '../lib1/ui/screens/splash_screen.dart';
import '../lib1/ui/screens/chat_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      name: "com.example.chat_app",
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        canvasColor: Colors.black87,
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        //   accentColor: Colors.deepPurple,
        //  accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (snapShot.hasData) {
              return ChatScreen();
            } else {
              return AuthScreen();
            }
          }),
    );
  }
}
*/
