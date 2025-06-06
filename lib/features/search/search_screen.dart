import 'package:flutter/material.dart' hide SearchController;
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/core/extensions/extension.dart';
import 'package:news_app/features/article/article_details.dart';
import 'package:news_app/features/home/widgets/news_card.dart';
import 'package:news_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

/// (DONE) TODO : Task - Add Controller To It
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchController>(
      create: (context) => SearchController(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Search News')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer(
            builder: (BuildContext context, SearchController sController, Widget? child) {
              return Column(
                children: [
                  TextField(
                    controller: sController.searchTextController,
                    decoration: InputDecoration(
                      hintText: 'Search for news...',
                      suffixIcon: const Icon(Icons.search, color: Color(0xFFA0A0A0),),
                    ),
                    onChanged: (value) => sController.searchNews(value),
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    child:
                    sController.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : sController.errorMessage != null
                        ? Center(child: Text(sController.errorMessage!))
                        : sController.articlesList.isEmpty
                        ? const Center(child: Text('No results found'))
                        : ValueListenableBuilder(
                      valueListenable: Hive.box('bookmarks').listenable(),
                      builder: (context, Box box, _) {
                        return ListView.builder(
                          itemCount: sController.articlesList.length,
                          itemBuilder: (context, index) {
                            final article = sController.articlesList[index];
                            final isBookmarked = box.containsKey(article.url);

                            return NewsCard(
                              article: article,
                              isBookmarked: isBookmarked,
                              formatTimeAgo: (date) => date.formatTimeAgo(),
                              onTap: () async {
                                final bool? result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ArticleDetails(index: index, sController: sController);
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),

                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
