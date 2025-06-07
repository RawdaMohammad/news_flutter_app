import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

import '../../core/service_locator.dart';
import '../home/repositories/base_news_api_repository.dart';

class SearchController with ChangeNotifier{
  final TextEditingController searchTextController = TextEditingController();
  List<NewsArticle> articlesList = [];
  bool isLoading = false;
  String? errorMessage;
  Timer? _debounce;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchNews(query);
    });
  }

  Future<void> searchNews(String query) async {
    query = query.trim();
    if (query.isEmpty) {
      articlesList = [];
      errorMessage = null;
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final repository = locator<BaseNewsApiRepository>();
      final articles = await repository.fetchEverything(query: query);
      articlesList = articles ?? [];
      isLoading = false;
      notifyListeners();

    } catch (e) {
      errorMessage = 'Failed to load news: $e';
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }
}