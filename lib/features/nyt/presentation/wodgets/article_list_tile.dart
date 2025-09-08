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
      leading: article.thumbnail != null && article.thumbnail!.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: article.thumbnail!,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              placeholder: (context, _) =>
                  const CircularProgressIndicator(strokeWidth: 2),
              errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
            )
          : const Icon(Icons.article, size: 40),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: article.author.isNotEmpty
          ? Text(article.author, maxLines: 1, overflow: TextOverflow.ellipsis)
          : null,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ArticleDetailPage(article: article)),
      ),
    );
  }
}
