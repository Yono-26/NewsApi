import 'package:flutter/material.dart';
import '../models/article_model.dart';
import '../services/api_service.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article>? _articles;
  String? _error;
  bool _isLoading = false;

  List<Article>? get articles => _articles;
  String? get error => _error;
  bool get isLoading => _isLoading;
  bool get hasData => _articles != null && _articles!.isNotEmpty;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      _articles = await ApiService().getArticle();
      _error = null;
    } catch (e) {
      _error = e.toString();
      _articles = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
