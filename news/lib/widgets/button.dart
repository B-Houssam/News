import 'dart:io';

import 'package:flutter/material.dart';

import '../views/home_page.dart';
import '../views/lost.dart';

class Button extends StatelessWidget {
  const Button({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: 1,
        child: Container(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            tooltip: 'Next Step',
            onPressed: () async {
              try {
                final result = await InternetAddress.lookup('google.com');
                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                  print('connected');
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                }
              } on SocketException catch (_) {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Lost()));
              }
            },
            elevation: 0,
            backgroundColor: Color(0XFFFFC15E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.arrow_forward),
          ),
        ));
  }
}
