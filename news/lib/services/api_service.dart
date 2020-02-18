import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/article_model.dart';

class ApiService {
  final String _baseUrl = 'api.nytimes.com';
  static const String _apiKey = 'W4uAIpTYEY8KNx3Wb0mfmtaO7HHJNBBG';


  Future<List<Article>> fetchArticlesBySection(String section) async {
    Map<String, String> parameters = {
      'api-key' : _apiKey,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/svc/topstories/v2/$section.json',
      parameters,
    );
    try {
      var response = await http.get(uri);
      Map<String, dynamic> data = json.decode(response.body);
      List<Article> articles = [];
      data['results'].forEach(
        (articleMap) => articles.add(Article.fromMap(articleMap)),
      );
    } catch (err) {
      throw err.toString();
    }
  }
}