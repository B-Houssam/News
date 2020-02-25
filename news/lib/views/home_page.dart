import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

import '../models/article_model.dart';
import '../models/trend.dart';
import '../services/api_service.dart';
import 'package:weather/weather.dart';

import '../services/api_trend.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  //Color colIcon = Article().col;
  List<Article> _articles = [];
  List<Article> _articlesH = [];
  List<Article> _articlesS = [];
  List<ArticleT> _articlesT = [];
  List<Article> _articlesA = [];
  List<Article> _articlesB = [];

  Weather _weth;
  bool isLoding = true;
  Color _color = Color(0xFF86819C);
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 5, vsync: this);
    _fetchArticles();
    _fetchTrends();
    _fetchWether();
    super.initState();
  }

  _fetchWether() async {
    try {
      WeatherStation _weatherSt =
          new WeatherStation('97c67c4d203208e953239bf12da03413');
      Weather weather = await _weatherSt.currentWeather();
      //debug
      //print('---->>>>>${weather.temperature.celsius}');
      setState(() {
        _weth = weather;
        isLoding = false;
      });
    } catch (e) {
      throw e.toString();
    }
  }

  _fetchTrends() async {
    List<ArticleT> articlesT = await ApiServiceT().fetchTrends();
    setState(() {
      _articlesT = articlesT;
      //print('----------------->>');
    });
  }

  _fetchArticles() async {
    List<Article> articles = await ApiService().fetchArticlesBySection('home');
    List<Article> articlesH =
        await ApiService().fetchArticlesBySection('health');
    List<Article> articlesS =
        await ApiService().fetchArticlesBySection('science');
    List<Article> articlesA = await ApiService().fetchArticlesBySection('arts');
    List<Article> articlesB =
        await ApiService().fetchArticlesBySection('books');
    setState(() {
      _articles = articles;
      _articlesH = articlesH;
      _articlesS = articlesS;
      _articlesA = articlesA;
      _articlesB = articlesB;

      //n = _articles.length;
      //print('-------->${_articles[49].title}');
      //debug
      //print('-------->${_articles.isEmpty}');
    });
  }

/*
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
*/
  _buildWeather() {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: _color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Morning, Houssam',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'QuickSandLight',
                    fontSize: 28,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 4)),
                Text(
                  'Here are the stories of today.',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontFamily: 'QuickSandLight',
                    fontSize: 15,
                  ),
                ),
                //Padding(padding: EdgeInsets.only(bottom: 10)),
              ],
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                    'http://openweathermap.org/img/wn/${_weth.weatherIcon}.png'),
              ],
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${_weth.temperature.celsius}°',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'QuickSandLight',
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${_weth.weatherMain}',
                  style: TextStyle(
                    fontFamily: 'QuickSandLight',
                    color: Colors.grey[100],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
/*
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
  */

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _buildCard() {
    return Padding(
        padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.transparent,
          ),
          child: Stack(children: <Widget>[
            PageIndicatorContainer(
              length: 5,
              indicatorSelectorColor: Color(0XFF3D84A8),
              indicatorColor: Colors.grey[300],
              shape: IndicatorShape.roundRectangleShape(
                  size: Size.square(8), cornerSize: Size.square(2)),
              align: IndicatorAlign.bottom,
              child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _launchUrl(_articlesT[index].url);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            '${_articlesT[index].imageUrl}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.6,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            //height: MediaQuery.of(context).size.height / 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [Colors.black, Colors.transparent],
                                )),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Text(
                            '${_articlesT[index].title}',
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'robotoReg',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              left: 20,
              top: 10,
              child: Text(
                "Today's trends",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: 'robotoMed',
                ),
              ),
            ),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return isLoding == true ||
            _articles.length == 0 ||
            _articlesT.length == 0 ||
            _articlesH.length == 0 ||
            _articlesS.length == 0 ||
            _articlesB.length == 0 ||
            _articlesA.length == 0
        ? Scaffold(
            backgroundColor: Colors.blueGrey[50],
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0XFF48466D)),
              ),
            ),
          )
        : Scaffold(
            drawer: Drawer(),
            backgroundColor: Colors.blueGrey[50],
            body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                        backgroundColor: Color(0XFF48466D),
                        floating: true,
                        actions: <Widget>[
                          //
                        ],
                        pinned: false,
                        elevation: 10,
                        centerTitle: true,
                        title: Text(
                          'News',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'playfair',
                            fontSize: 30,
                          ),
                        ),
                        flexibleSpace: FlexibleSpaceBar()),
                    SliverPersistentHeader(
                      pinned: false,
                      floating: false,
                      delegate: _SliverAppBarDelegate(Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: _buildWeather(),
                        ),
                        decoration: BoxDecoration(
                          color: _color,
                        ),
                      )),
                    ),
                  ];
                },
                body: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 1,
                        endIndent: 20,
                        indent: 20,
                        color: Colors.grey,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 4,
                        child: _buildCard(),
                      ),
                      Container(
                        height: 50,
                        child: TabBar(
                          indicatorColor: Color(0XFF3D84A8),
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          isScrollable: true,
                          tabs: <Widget>[
                            Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'quickSandLight',
                                color: Color(0XFF48466D),
                              ),
                            ),
                            Text(
                              'Health',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'quickSandLight',
                                color: Color(0XFF48466D),
                              ),
                            ),
                            Text(
                              'Science',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'quickSandLight',
                                color: Color(0XFF48466D),
                              ),
                            ),
                            Text(
                              'Arts',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'quickSandLight',
                                color: Color(0XFF48466D),
                              ),
                            ),
                            Text(
                              'Books',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'quickSandLight',
                                color: Color(0XFF48466D),
                              ),
                            ),
                          ],
                          controller: _tabController,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: <Widget>[
                            ListView.separated(
                              separatorBuilder: (conext, index) => Divider(
                                color: Colors.grey[300],
                              ),
                              padding: EdgeInsets.only(bottom: 3, top: 10),
                              itemCount: _articles.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrl(_articles[i].url);
                                      },
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: Container(
                                          height: 45,
                                          width: 45,
                                          child: Image.asset(
                                            'assets/nytimesLogo.png',
                                            //fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 8,
                                                  spreadRadius: 0.4,
                                                  offset: Offset(1.0, 1.0)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          _articles[i].publishedDate,
                                          style: TextStyle(
                                            fontFamily: 'quickSandLight',
                                            fontSize: 13,
                                          ),
                                        ),
                                        trailing: Image.network(
                                            _articles[i].imageUrl),
                                        title: Text(_articles[i].title),
                                      ),
                                    ));
                              },
                            ),
                            ListView.separated(
                              separatorBuilder: (conext, index) => Divider(
                                color: Colors.grey[300],
                              ),
                              padding: EdgeInsets.only(bottom: 3, top: 10),
                              itemCount: _articlesH.length,
                              itemBuilder: (context, j) {
                                return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrl(_articlesS[j].url);
                                      },
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: Container(
                                          height: 45,
                                          width: 45,
                                          child: Image.asset(
                                            'assets/nytimesLogo.png',
                                            //fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 8,
                                                  spreadRadius: 0.4,
                                                  offset: Offset(1.0, 1.0)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          _articlesH[j].publishedDate,
                                          style: TextStyle(
                                            fontFamily: 'quickSandLight',
                                            fontSize: 13,
                                          ),
                                        ),
                                        trailing: Image.network(
                                            _articlesH[j].imageUrl),
                                        title: Text(_articlesH[j].title),
                                      ),
                                    ));
                              },
                            ),
                            ListView.separated(
                              separatorBuilder: (conext, index) => Divider(
                                color: Colors.grey[300],
                              ),
                              padding: EdgeInsets.only(bottom: 3, top: 10),
                              itemCount: _articlesS.length,
                              itemBuilder: (context, k) {
                                return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrl(_articlesS[k].url);
                                      },
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: Container(
                                          height: 45,
                                          width: 45,
                                          child: Image.asset(
                                            'assets/nytimesLogo.png',
                                            //fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 8,
                                                  spreadRadius: 0.4,
                                                  offset: Offset(1.0, 1.0)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          _articlesS[k].publishedDate,
                                          style: TextStyle(
                                            fontFamily: 'quickSandLight',
                                            fontSize: 13,
                                          ),
                                        ),
                                        trailing: Image.network(
                                            _articlesS[k].imageUrl),
                                        title: Text(_articlesS[k].title),
                                      ),
                                    ));
                              },
                            ),
                            ListView.separated(
                              separatorBuilder: (conext, index) => Divider(
                                color: Colors.grey[300],
                              ),
                              padding: EdgeInsets.only(bottom: 3, top: 10),
                              itemCount: _articlesA.length,
                              itemBuilder: (context, m) {
                                return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrl(_articlesA[m].url);
                                      },
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: Container(
                                          height: 45,
                                          width: 45,
                                          child: Image.asset(
                                            'assets/nytimesLogo.png',
                                            //fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 8,
                                                  spreadRadius: 0.4,
                                                  offset: Offset(1.0, 1.0)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          _articlesA[m].publishedDate,
                                          style: TextStyle(
                                            fontFamily: 'quickSandLight',
                                            fontSize: 13,
                                          ),
                                        ),
                                        trailing: Image.network(
                                            _articlesA[m].imageUrl),
                                        title: Text(_articlesA[m].title),
                                      ),
                                    ));
                              },
                            ),
                            ListView.separated(
                              separatorBuilder: (conext, index) => Divider(
                                color: Colors.grey[300],
                              ),
                              padding: EdgeInsets.only(bottom: 3, top: 10),
                              itemCount: _articlesB.length,
                              itemBuilder: (context, n) {
                                return Padding(
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: GestureDetector(
                                      onTap: () {
                                        _launchUrl(_articlesB[n].url);
                                      },
                                      child: ListTile(
                                        isThreeLine: true,
                                        leading: Container(
                                          height: 45,
                                          width: 45,
                                          child: Image.asset(
                                            'assets/nytimesLogo.png',
                                            //fit: BoxFit.cover,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 8,
                                                  spreadRadius: 0.4,
                                                  offset: Offset(1.0, 1.0)),
                                            ],
                                          ),
                                        ),
                                        subtitle: Text(
                                          _articlesB[n].publishedDate,
                                          style: TextStyle(
                                            fontFamily: 'quickSandLight',
                                            fontSize: 13,
                                          ),
                                        ),
                                        trailing: Image.network(
                                            _articlesB[n].imageUrl),
                                        title: Text(_articlesB[n].title),
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
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
  double get maxExtent => 150;

  @override
  double get minExtent => 150;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
