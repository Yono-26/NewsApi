import 'dart:convert';

import 'package:http/http.dart';
import 'package:news_app/models/article_model.dart';

class ApiService {
  final endPointUrl =
      "https://newsapi.org/v2/everything?q=apple&from=2025-04-16&to=2025-04-16&sortBy=popularity&apiKey=3931695ccc584a659e795dbc05dd5509";

  // Lets make a Http request

  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    //Checking the status code
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
