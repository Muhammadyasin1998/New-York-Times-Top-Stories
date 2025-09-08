import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';


class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          article.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image (if available)
            if (article.largeImage != null && article.largeImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  article.largeImage!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 80),
                ),
              ),

            const SizedBox(height: 16),

            // Title
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 8),

            // Byline
            if (article.byline != null && article.byline!.isNotEmpty)
              Text(
                article.byline!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700],
                    ),
              ),

            const SizedBox(height: 12),

            // Abstract
            Text(
              article.abstract ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 24),

            // Read Full Article Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/article-webview', extra: {
                    'url': article.url,
                    'title': article.title,
                  });
                },
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Read Full Article'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
