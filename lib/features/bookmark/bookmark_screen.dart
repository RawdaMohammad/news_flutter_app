import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/extensions/extension.dart';
import 'package:news_app/features/home/widgets/news_card.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  /// (DONE) TODO : Task - Make it shared and make it extension

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: ValueListenableBuilder(
        /// (DONE) TODO : Task - Don't Add Hard Coded Values
        valueListenable: Hive.box(StorageKey.bookmarks).listenable(),
        builder: (context, Box box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No bookmarked articles yet'));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final article = box.getAt(index);
              return NewsCard(
                article: article,
                isBookmarked: true,
                onBookmarkPressed: () {
                  box.deleteAt(index);
                },
                formatTimeAgo: (date) => date.formatTimeAgo(),
              );
            },
          );
        },
      ),
    );
  }
}
