import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/splash.dart';
/*
import 'views/OnBoard.dart';
import 'views/home_page.dart';
import 'views/lost.dart';
*/

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
