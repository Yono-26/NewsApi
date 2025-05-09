import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/services/api_service.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _articles = [];
  String? _error;
  bool _isLoading = false;
  bool _isCloseIcon = false;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMore = true;
  bool _isFetchingMore = false;

  List<Article> get articles => _articles;
  String? get error => _error;
  bool get isLoading => _isLoading;
  bool get isCloseIcon => _isCloseIcon;
  bool get hasData => _articles.isNotEmpty;
  bool get hasMore => _hasMore;

  Future<void> fetchRecentNews() async {
    _isLoading = true;
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();

    try {
      final fetchedArticles =
      await ApiService().getTopHeadlines(page: _currentPage, pageSize: _pageSize);
      _articles = fetchedArticles;
      _error = null;
      _hasMore = fetchedArticles.length == _pageSize;
    } catch (e) {
      _error = e.toString();
      _articles = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMoreNews() async {
    if (_isFetchingMore || !_hasMore) return;

    _isFetchingMore = true;
    notifyListeners();

    try {
      _currentPage++;
      final moreArticles = await ApiService()
          .getTopHeadlines(page: _currentPage, pageSize: _pageSize);

      if (moreArticles.isEmpty) {
        _hasMore = false;
      } else {
        _articles.addAll(moreArticles);
        _hasMore = moreArticles.length == _pageSize;
      }
    } catch (e) {
      _error = e.toString();
    }

    _isFetchingMore = false;
    notifyListeners();
  }

  Future<void> fetchArticleByQuery(String query) async {
    _isLoading = true;
    _currentPage = 1;
    _hasMore = true;
    notifyListeners();

    try {
      final searchResults = await ApiService()
          .getArticleByQuery(query, page: _currentPage, pageSize: _pageSize);
      _articles = searchResults;
      _error = null;
      _hasMore = searchResults.length == _pageSize;
    } catch (e) {
      _error = e.toString();
      _articles = [];
    }

    _isCloseIcon = true;
    _isLoading = false;
    notifyListeners();
    
  }

  void updateSearchText(String text) {
    _isCloseIcon = text.isNotEmpty;
    notifyListeners();
  }

  void closeSearch() {
    _isCloseIcon = false;
    fetchRecentNews();
    _error = null;
    notifyListeners();
  }
}
