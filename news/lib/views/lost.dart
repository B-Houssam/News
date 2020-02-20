import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_page.dart';

class Lost extends StatefulWidget {
  Lost({Key key}) : super(key: key);

  @override
  _LostState createState() => _LostState();
}

class _LostState extends State<Lost> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBar(){
    final snacky = SnackBar(content: Text('Not yet connected  :(', textAlign: TextAlign.center,));
    _scaffoldKey.currentState.showSnackBar(snacky);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0XFFF3F3F3),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width * .77,
                height: MediaQuery.of(context).size.height * .06,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                  onPressed: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        print('connected');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      }
                    } on SocketException catch (_) {
                      _showSnackBar();
                      /*
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Lost()));
                      */
                    }
                  },
                  color: Color(0XFFf9a826),
                  child: Text(
                    'Try again',
                    style: TextStyle(
                      color: Colors.grey[50],
                      fontFamily: "robotoReg",
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 140, bottom: 70, left: 70, right: 70),
              child: Image.asset('assets/lost.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70, left: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "OOPS !",
                    style: TextStyle(
                      color: Color(0XFFf9a826),
                      fontFamily: "playfairBlack",
                      fontSize: 35,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Text(
                    "It seems that you lost connection\n\nif you are in a cave,\nwe recommande you to go out ;)",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: "robotoReg",
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
