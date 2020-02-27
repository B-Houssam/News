import 'package:flutter/material.dart';

class First extends StatelessWidget {
  const First({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 7)),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Color(0XFF48466D),
                    fontFamily: "playfairBlack",
                    fontSize: 35,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 1)),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "to your handy news app",
                  style: TextStyle(
                    fontFamily: "robotoMed",
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 12)),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "This app will help you keep up with",
                  style: TextStyle(
                    fontFamily: "robotoReg",
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "what's going on out there!",
                  style: TextStyle(
                    fontFamily: "robotoReg",
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Container(
                  width: MediaQuery.of(context).size.width * .8,
                  child: Image.asset("assets/1.png"),
                ))),
      ],
    );
  }
}

//-----------------------------------------------------------------------------------//

class Seconde extends StatelessWidget {
  const Seconde({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: EdgeInsets.symmetric(vertical: 7)),
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "The",
                        style: TextStyle(
                          //color: Color(0XFF575A88),
                          fontFamily: "robotoMed",
                          fontSize: 20,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                      Padding(
                        padding: EdgeInsets.only(bottom: 11),
                        child: Text(
                          "NewYork Times.",
                          style: TextStyle(
                            fontFamily: "playfairBlack",
                            color: Color(0XFF48466D),
                            fontSize: 30,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                      ),
                    ],
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 12)),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "all the news,",
                  style: TextStyle(
                    fontFamily: "robotoReg",
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "any where, any time.",
                  style: TextStyle(
                    fontFamily: "robotoReg",
                    color: Colors.grey[500],
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Container(
                  width: MediaQuery.of(context).size.width * .77,
                  child: Image.asset("assets/2.png"),
                ))),
      ],
    );
  }
}
