import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

import '../widgets/button.dart';
import 'home_page.dart';
import 'lost.dart';
import 'pages.dart';
/*
import '../Pages/pages.dart';
*/

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  bool _visible = false;
  bool _visible2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF3F3F3),
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        top: 60,
                        left: 26,
                      ),
                      child: Container(
                        height: 70,
                        width: 70,
                        child: Image.asset("assets/logo.png"),
                        decoration: BoxDecoration(
                          color: Color(0XFFFFC15E),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8,
                                spreadRadius: 0.4,
                                offset: Offset(6.0, 6.0)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15, top: 30),
                      child: Align(
                          alignment: Alignment.topRight,
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 100),
                            opacity: _visible2 ? 1.0 : 0.0,
                            child: FlatButton.icon(
                              onPressed: () async {
                                try {
                                  final result = await InternetAddress.lookup(
                                      'google.com');
                                  if (result.isNotEmpty &&
                                      result[0].rawAddress.isNotEmpty) {
                                    print('connected');
                                     Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()));
                                  }
                                } on SocketException catch (_) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Lost()));
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.grey,
                              ),
                              label: Text(
                                "Skip",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                          )),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                        child: Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: PageIndicatorContainer(
                      indicatorColor: Colors.grey[300],
                      indicatorSelectorColor: Color(0XFFf9a826),
                      shape: IndicatorShape.roundRectangleShape(
                          size: Size.square(8), cornerSize: Size.square(2)),
                      length: 2,
                      align: IndicatorAlign.bottom,
                      child: PageView(
                        onPageChanged: (int page) {
                          getP(page);
                          //print(page);
                        },
                        children: <Widget>[
                          First(),
                          Seconde(),
                        ],
                      )),
                )))
              ],
            ),
            //----//
            Padding(
              padding: EdgeInsets.only(right: 20, bottom: 20),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: _visible ? 1.0 : 0.0,
                      child: Button())),
            ),
          ],
        ));
  }

  void getP(int page) {
    setState(() {
      if (page == 1) {
        _visible2 = !_visible2;
        _visible = !_visible;
      } else {
        if (page == 0) {
          _visible = false;
          _visible2 = true;
        }
      }
    });
  }
}
