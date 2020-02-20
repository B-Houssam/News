
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Article {

  final String title;
  final String byline;
  final String url;
  final String imageUrl;
  final String publishedDate;
  final String summary;
  Color col = Colors.black;
  dynamic shape = EvaIcons.heartOutline;

  Article({
    this.title,
    this.byline,
    this.url,
    this.imageUrl,
    this.publishedDate,
    this.summary,
  });

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'],
      byline: map['byline'],
      url: map['url'],
      imageUrl: map['multimedia'].length > 0
          ? map['multimedia'][3]['url']
          : 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80',
      publishedDate: map['published_date'],
      summary: map['abstract'],
    );
  }
}