import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/models/article_model.dart';

class ApiService {
  Future<List<Article>> getArticleByQuery(String query) async {
    final url = 'https://newsapi.org/v2/everything?q=$query&apiKey=3931695ccc584a659e795dbc05dd5509';
    final uri = Uri.parse(url);

    Response res = await get(uri);

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
