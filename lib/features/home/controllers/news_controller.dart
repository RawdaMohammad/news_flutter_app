import 'package:flutter/cupertino.dart';

import '../../../core/service_locator.dart';
import '../models/news_article_model.dart';
import '../repositories/base_news_api_repository.dart';

class NewsController with ChangeNotifier{
  final BaseNewsApiRepository repository = locator<BaseNewsApiRepository>();
  List<NewsArticle> topHeadlines = [];
  List<NewsArticle> everythingArticles = [];
  bool isLoadingHeadlines = true;
  bool isLoadingEverything = true;
  String selectedCategory = 'Top News';

  final List<String> categories = [
    'Top News',
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology',
  ];

  init() {
    loadNews();
  }

  Future<void> loadNews() async {
    isLoadingHeadlines = true;
    isLoadingEverything = true;
    notifyListeners();

    try {
      final headlines = await repository.fetchTopHeadlines(
        category: selectedCategory == 'Top News' ? 'general' : selectedCategory,
      );
      topHeadlines = headlines;
      isLoadingHeadlines = false;
      notifyListeners();
    } catch (_) {
      topHeadlines = [];
      isLoadingHeadlines = false;
      notifyListeners();
    }

    try {
      final everything = await repository.fetchEverything(
        query: selectedCategory == 'Top News' ? 'news' : selectedCategory,
      );
      everythingArticles = everything;
      isLoadingEverything = false;
      notifyListeners();
    } catch (_) {
      everythingArticles = [];
      isLoadingEverything = false;
      notifyListeners();
    }
  }
}