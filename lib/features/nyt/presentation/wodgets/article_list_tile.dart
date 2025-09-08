import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/presentation/pages/article_detail_page.dart';

class ArticleListItem extends StatelessWidget {
  final ArticleEntity article;
  const ArticleListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:  const SizedBox(width: 56, child: Icon(Icons.article)),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle:
          Text(article.byline, maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ArticleDetailPage(article: article)),
      ),
    );
  }
}
