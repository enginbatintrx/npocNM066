import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:npocnm/screens/post/commentPage.dart';
import 'package:npocnm/screens/createPost.dart';
import 'package:npocnm/screens/login.dart';
import 'package:npocnm/screens/mainScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'models/post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      title: "NpocNM",
      locale: Locale("en"),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
        '/commentPage': (context) => CommentsPage(),
        '/createPost': (context) => CreatePost(),
      },
    );
  }
}
