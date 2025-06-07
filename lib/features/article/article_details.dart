import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:news_app/core/extensions/extension.dart';
import 'package:news_app/features/article/article_details.dart';
import 'package:news_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

import '../home/models/news_article_model.dart';

class ArticleDetails extends StatefulWidget {
  ArticleDetails({super.key, required this.index, required this.article, required this.isBookmarked});

  final int index;
  final NewsArticle article;
  bool isBookmarked;

  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article Details')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CachedNetworkImage(
                    imageUrl: widget.article.urlToImage ?? '',
                    width: 400,
                    height: 228,
                    fit: BoxFit.cover,
                    placeholder:
                        (_, __) => Container(width: 122, color: Colors.grey.shade400),
                    errorWidget:
                        (_, __, ___) =>
                            Container(width: 122, color: Colors.grey.shade400),
                  ),
                  SizedBox(height: 12),
                  Text(
                    widget.article.title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      // Row()
                      Text(
                        widget.article.sourceName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 12),
                      Text(
                        widget.article.publishedAt.formatTimeAgo(),
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                      // SizedBox(width: 135),
                      Spacer(),
                      SvgPicture.asset(
                        'assets/images/share_icon.svg',
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 13),
                      IconButton(
                        icon: Icon(
                          widget.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color:
                          widget.isBookmarked
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).iconTheme.color,
                          size: 30,
                        ),
                        onPressed: () {
                          final box = Hive.box('bookmarks');
                          setState(() {
                            if (widget.isBookmarked) {
                              box.delete(widget.article.url);
                              widget.isBookmarked = false;
                            } else {
                              box.put(widget.article.url, widget.article);
                              widget.isBookmarked = true;
                            }
                          });
                        },

                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Container(
                    width: 400,
                    height: 648,
                    child: Text(
                      "humanitarian initiative led by the Life Again Education and Culture Foundation with the support of Türkiye Sigorta. The project brought a group of children from Kahramanmaraş and surrounding earthquake-affected regions to Istanbul for a series of events aimed at supporting their psychological recovery and personal development.As part of the program, the children attended the Türkiye Sigorta Basketball Super League Asım Pars season playoff quarterfinal between Anadolu Efes and Mersin Spor on Friday, May 30, 2025. More than a recreational outing, the match provided the children with a joyful and memorable experience designed to boost their morale and help them reconnect with life after enduring profound trauma.The Istanbul visit is a central component of a broader psychosocial support initiative that combines sports, education and culture to aid the children's healing. In addition to the basketball game, the children are visiting interactive learning centers such as KidZania Istanbul, where they can explore careers, experiment with science and engage in role-playing activities. The goal is to provide both entertainment and educational value, nurturing their sense of curiosity and imagination.",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
