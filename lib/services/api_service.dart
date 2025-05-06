import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/article_model.dart';

class ApiService {
  final String _baseUrl = 'https://newsapi.org/v2';
  final String _apiKey = '3931695ccc584a659e795dbc05dd5509';

  Future<List<Article>> getTopHeadlines({int page = 1, int pageSize = 10}) async {
    final url =
        '$_baseUrl/top-headlines?country=us&page=$page&pageSize=$pageSize&apiKey=$_apiKey';
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> body = json['articles'];

      return body.map((item) => Article.fromJson(item)).toList();
    } else {
      throw Exception("Failed to fetch top headlines");
    }
  }

  Future<List<Article>> getArticleByQuery(String query, {int page = 1, int pageSize = 10}) async {
    final url =
        'https://newsapi.org/v2/everything?q=$query&page=$page&pageSize=$pageSize&apiKey=3931695ccc584a659e795dbc05dd5509';
    final uri = Uri.parse(url);

    http.Response res = await http.get(uri);

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);
      List<dynamic> body = json['articles'];

      List<Article> articles =
      body.map((dynamic item) => Article.fromJson(item)).toList();
      return articles;
    } else {
      throw ("Can't get the Article");
    }
  }
}
