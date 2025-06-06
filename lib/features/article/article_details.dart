import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/extensions/extension.dart';
import 'package:news_app/features/article/article_details.dart';
import 'package:news_app/features/search/search_controller.dart';
import 'package:provider/provider.dart';

class ArticleDetails extends StatelessWidget {
  const ArticleDetails({super.key, required this.index, required this.sController});

  final int index;
  final SearchController sController;
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
                    imageUrl: sController.articlesList[index].urlToImage ?? '',
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
                    sController.articlesList[index].title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      // Row()
                      Text(
                        sController.articlesList[index].sourceName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 12),
                      Text(
                        sController.articlesList[index].publishedAt.formatTimeAgo(),
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
                      SvgPicture.asset(
                        'assets/images/bookMark.svg',
                        width: 24,
                        height: 24,
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
