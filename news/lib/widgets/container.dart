import 'package:flutter/material.dart';

import '../models/article_model.dart';
import '../services/api_service.dart';

class Cont extends StatefulWidget {
  Cont({Key key}) : super(key: key);

  @override
  _ContState createState() => _ContState();
}

class _ContState extends State<Cont> {
  List<Article> _articles = [];
  @override
  void initState() {
    super.initState();

    _fetchArticles();
  }

  _fetchArticles() async {
    List<Article> articles = await ApiService().fetchArticlesBySection('technology');
    setState(() {
      _articles = articles;
      //print('->>>>${_articles[1].title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    //var n = _articles.length;
    //print(n);
    return Center(
      child: Container(

      ),
    );
  }
}
