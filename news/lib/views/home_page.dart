import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../services/api_service.dart';
import '../widgets/placeholders_lines.dart';
import 'lost.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Color colIcon = Article().col;
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  _fetchArticles() async {
    List<Article> articles =
        await ApiService().fetchArticlesBySection('technology');
    setState(() {
      _articles = articles;
      //print('->>>>${_articles[1].title}');
    });
  }

  setCol(index) {
    setState(() {
      if (_articles[index].col == Colors.black) {
        _articles[index].col = Colors.red;
        _articles[index].shape = EvaIcons.heart;
      } else {
        _articles[index].col = Colors.black;
        _articles[index].shape = EvaIcons.heartOutline;
      }
    });
  }

  _buildContaier(var index) {
    return GestureDetector(
      onDoubleTap: () {
        setCol(index);
      },
      child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0XFFF3F3F3),
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        height: 43,
                        width: 43,
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.fill,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0XFFFFC15E),
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 8,
                                spreadRadius: 0.4,
                                offset: Offset(6.0, 6.0)),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width - 100,
                            ),
                            child: Text(
                              '${_articles[index].title}',
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'robotoReg',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                height: MediaQuery.of(context).size.height / 11,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
              ),
              Expanded(
                child: Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    Container(
                      child: Image.network(_articles[index].imageUrl,
                          fit: BoxFit.fill),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 10, bottom: 10),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "${_articles[index].summary}".substring(0, 70) +
                              "...",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "robotoBlack",
                            //fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Icon(
                        _articles[index].shape,
                        size: 35,
                        color: _articles[index].col,
                      ),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 5),
                  child: Text(
                    'Published on: ' + '${_articles[index].publishedDate}',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _buildCardExample() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 9,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        width: 300,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.6),
              ),
              child: Center(
                child: Icon(
                  Icons.photo_size_select_actual,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
            Expanded(
              child: PlaceholderLines(
                count: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF3F3F3),
        appBar: AppBar(
          backgroundColor: Color(0XFFFFC15E),
        ),
        body: _articles.length == 0
            ? Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: _buildCardExample(),
                ),
              )
            : ListView.builder(
                padding: EdgeInsets.only(bottom: 10),
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: _buildContaier(index));
                },
              ));
  }
}
