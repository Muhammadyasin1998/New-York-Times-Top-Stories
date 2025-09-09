import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/shammer_place_holder.dart';
import 'package:shimmer/shimmer.dart';


class ArticleListItem extends StatelessWidget {
  final ArticleEntity article;
  const ArticleListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: article.thumbnail != null && article.thumbnail!.isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.circular(10),

            child: CachedNetworkImage(
                imageUrl: article.thumbnail!,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                placeholder: (context, _) => const ShimmerPlaceholder(
                  width: 56,
                  height: 56,
                ),
                errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
              ),
          )
          : const Icon(Icons.article, size: 40),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: article.author.isNotEmpty
          ? Text(article.author, maxLines: 1, overflow: TextOverflow.ellipsis)
          : null,
      onTap: () => context.push(
        '/article-detail',
        extra: article,
      ),
    );
  }
}




