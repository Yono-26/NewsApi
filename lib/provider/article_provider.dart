import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/api_service.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article>? _articles;
  String? _error;
  bool _isLoading = false;
  List<Article>? _filteredArticles;

  List<Article>? get articles => _articles;
  List<Article>? get filteredArticles => _filteredArticles ?? _articles;
  String? get error => _error;
  bool get isLoading => _isLoading;
  bool get hasData => _articles != null && _articles!.isNotEmpty;

  Future<void> fetchArticleByQuery(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await ApiService().getArticleByQuery(query);
      _filteredArticles = _articles;
      _error = null;
    } catch (e) {
      _error = e.toString();
      _articles = null;
      _filteredArticles = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
