import 'package:chat_app/constants/global_constants.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/locale_provider.dart';
import 'services/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
      name: "com.example.chat_app",
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider=Provider.of<AuthProvider>(context,listen: false);

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
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
              future: authProvider.userSignedIn(),
              builder: (context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                }
                return  Scaffold(
                  backgroundColor: scafold_background,
                  body: Center(
                    child: SpinKitWave(color: mygreen,size: 75,),
                  ),
                );
              }));
    });
  }
}
