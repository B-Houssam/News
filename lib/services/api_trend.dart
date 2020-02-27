import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/trend.dart';

class ApiServiceT {
  static const String _apiKey = '->> YOUR API KEY from NYTimes';

  Future<List<ArticleT>> fetchTrends() async {
    try {
      var response = await http.get(
          'https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=$_apiKey');
      Map<String, dynamic> dat = json.decode(response.body);
      List<ArticleT> articlesT = [];

      for (var i = 0; i < 5; i++) {
        ArticleT a = new ArticleT(
          title: dat['results'][i]['title'],
          imageUrl: dat['results'][i]['media'].length == 0
              ? 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80'
              : dat['results'][i]['media'][0]['media-metadata'][2]['url'],
          url: dat['results'][i]['url'],
        );
        articlesT.add(a);
      }
      return articlesT;
    } catch (err) {
      throw err.toString();
    }
  }
}
