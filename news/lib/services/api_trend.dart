import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/trend.dart';

class ApiServiceT {
  static const String _apiKey = 'j5W2orz2txPbg63pMTJTrIGXioF9Ywte';

  Future<List<ArticleT>> fetchTrends() async {
    try {
      var response = await http.get(
          'https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=$_apiKey');
      Map<String, dynamic> dat = json.decode(response.body);
      List<ArticleT> articlesT = [];

      for (var i = 0; i < 5; i++) {
        ArticleT a = new ArticleT(
          title: dat['results'][i]['title'],
          imageUrl: dat['results'][i]['media'][0]['media-metadata'][2]['url'],
          url: dat['results'][i]['url'],
        );
        articlesT.add(a);
      }

      //print(dat['results'][0]['media'][0]['media-metadata'][2]['url']);
      print(articlesT.length);
      return articlesT;
    } catch (err) {
      throw err.toString();
    }
  }
}
