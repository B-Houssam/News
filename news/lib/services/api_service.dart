import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class ApiService {
  static const String _apiKey = 'W4uAIpTYEY8KNx3Wb0mfmtaO7HHJNBBG';

  Future<List<Article>> fetchArticlesBySection(String section) async {
    try {
      var response = await http.get(
          'https://api.nytimes.com/svc/topstories/v2/$section.json?api-key=$_apiKey');
      //print('api.nytimes.com/svc/topstories/v2/$section.json?api-key=$_apiKey');
      Map<String, dynamic> data = json.decode(response.body);
      //var n = data.length;
      List<Article> articles = [];
      data['results'].forEach(
        (articleMap) => articles.add(Article.fromMap(articleMap)),
      );

      //print('->>>>> ${articles.length}');

      return articles;
    } catch (err) {
      throw err.toString();
    }
  }
}
