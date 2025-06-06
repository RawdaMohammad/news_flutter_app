import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/core/extensions/extension.dart';
import 'package:provider/provider.dart';

import '../home/controllers/news_controller.dart';
import '../home/widgets/news_card.dart';

class TrendingNewsScreen extends StatelessWidget {
  const TrendingNewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewsController>(
      create: (context) => NewsController()..init(),
      child: Consumer<NewsController>(
        builder: (context, newsController, child) {
          return Scaffold(
            appBar: AppBar(title: const Text('Trending News')),
            body: CustomScrollView(
              slivers: [
                newsController.isLoadingHeadlines
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
                        itemCount: newsController.topHeadlines.length,
                        itemBuilder: (context, index) {
                          final article = newsController.topHeadlines[index];
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
