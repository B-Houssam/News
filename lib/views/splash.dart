import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'OnBoard.dart';
import 'lost.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    const fSec = const Duration(
      seconds: 2,
    );
    new Timer(fSec, () => _go());
  }

  _go() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OnBoard()));
      }
    } on SocketException catch (_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Lost()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF48466D),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * .5,
          height: MediaQuery.of(context).size.height * .3,
          child: Image.asset('assets/logo.png'),
        ),
      ),
    );
  }
}
