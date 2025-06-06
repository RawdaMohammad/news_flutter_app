import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/extensions/extension.dart';
import 'package:news_app/core/service_locator.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/features/home/repositories/base_news_api_repository.dart';
import 'package:news_app/features/home/repositories/news_api_repository.dart';
import 'package:news_app/features/home/widgets/category_list_widget.dart';
import 'package:news_app/features/home/widgets/news_card.dart';
import 'package:news_app/features/home/widgets/trending_news_widget.dart';
import 'package:provider/provider.dart';

import 'controllers/news_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsController>(
      create: (context) => NewsController()..init(),
      child: Consumer(
        builder: (BuildContext context, NewsController newsController, Widget? child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: TrendingNews(
                    isLoading: newsController.isLoadingHeadlines,
                    articles: newsController.topHeadlines,
                    formatTimeAgo: (date) => date.formatTimeAgo(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: CategoryList(
                      categories: newsController.categories,
                      selectedCategory: newsController.selectedCategory,
                      onCategorySelected: (category) {
                        newsController.selectedCategory = category;
                        newsController.loadNews();
                      },
                    ),
                  ),
                ),
                newsController.isLoadingEverything
                    ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    )
                    : SliverToBoxAdapter(
                      child: ValueListenableBuilder(
                        valueListenable: Hive.box('bookmarks').listenable(),
                        builder: (context, Box box, _) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: newsController.everythingArticles.length,
                            itemBuilder: (context, index) {
                              final article = newsController.everythingArticles[index];
                              final isBookmarked = box.containsKey(article.url);
                              return NewsCard(
                                article: article,
                                isBookmarked: isBookmarked,
                                formatTimeAgo: (date) => date.formatTimeAgo(),
                              );
                            },
                          );
                        },
                      ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
