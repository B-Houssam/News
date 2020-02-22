import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../services/api_service.dart';
import '../widgets/placeholders_lines.dart';
import 'package:connectivity/connectivity.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Color colIcon = Article().col;
  List<Article> _articles = [];
  int n = 0;

/*
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showSnackBar() {
    final snacky = SnackBar(
        content: Text(
      'Lost connection !',
      textAlign: TextAlign.center,
    ));
    _scaffoldKey.currentState.showSnackBar(snacky);
  }
*/
  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  _fetchArticles() async {
    List<Article> articles = await ApiService().fetchArticlesBySection('home');
    setState(() {
      _articles = articles;
      //n = _articles.length;
      print('-------->${_articles[49].title}');
      //debug
      //print('-------->${_articles.isEmpty}');
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
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 7,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black, Colors.transparent],
                        )),
                      ),
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
                  padding: const EdgeInsets.only(left: 15, bottom: 13),
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

  _buildWeather() {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFF2F2F2),
          //borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              'Morning, houssam',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'robotoMed',
                fontWeight: FontWeight.w300,
                fontSize: 30,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 2)),
            Text(
              'Here are you top stories of today.',
              style: TextStyle(
                color: Colors.grey[600],
                fontFamily: 'robotoReg',
                fontSize: 14,
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Container(
              height: 110,
              decoration: BoxDecoration(
                  color: Color(0XFFF2F2F2),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[350],
                        blurRadius: 9,
                        offset: Offset(11.0, 12.0)),
                  ]),
            )
          ],
        ),
      ),
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
      drawer: Drawer(),
      backgroundColor: Color(0xFFF2F2F2),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  backgroundColor: Color(0XFFFFC15E),
                  //expandedHeight: 300.0,
                  floating: true,
                  actions: <Widget>[
                    //
                  ],
                  pinned: false,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'News',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'playfair',
                      //fontWeight: FontWeight.w900,
                      fontSize: 30,
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar()),
              SliverPersistentHeader(
                pinned: false,
                delegate: _SliverAppBarDelegate(Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: _buildWeather(),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0XFFF2F2F2),
                  ),
                )),
              ),
            ];
          },
          body: _articles.length == 0
              ? Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          _buildCardExample(),
                          _buildCardExample(),
                        ],
                      )),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(bottom: 10),
                  itemCount: _articles.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: ListTile(
                        trailing: Image.network(_articles[i].imageUrl),
                        title: Text(_articles[i].title),
                      )
                    );
                  },
                )),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Container _cont;

  _SliverAppBarDelegate(this._cont);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _cont,
    );
  }

  @override
  double get maxExtent => 230;

  @override
  double get minExtent => 230;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
