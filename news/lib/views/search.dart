import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    floating: true,
                    pinned: true,
                    elevation: 10,
                    centerTitle: false,
                    backgroundColor: Color(0XFF48466D),
                    title: Text(
                      'Search',
                      style: TextStyle(
                        fontFamily: 'quickSandLight',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar()),
                SliverPersistentHeader(
                  pinned: false,
                  floating: false,
                  delegate: _SliverAppBarDelegate(Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .7,
                          child: Visibility(
                              visible: false, child: TextFormField()),
                        ),
                      ],
                    ),
                  )),
                ),
              ];
            },
            body: Center(
              child: Text(
                'Search for key-words in the NYTimes API',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'robotoReg',
                ),
              ),
            )));
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
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
