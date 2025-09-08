import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';


class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(article.title,
              maxLines: 1, overflow: TextOverflow.ellipsis)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.largeImage != null && article.largeImage!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: article.largeImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 220,
                placeholder: (context, _) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) =>
                    const Icon(Icons.broken_image, size: 80),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(article.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            if (article.author.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("By ${article.author}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ),
            if (article.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(article.description,
                    style: const TextStyle(fontSize: 16)),
              ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => ArticleWebviewPage(
                  //       url: article.url,
                  //       title: article.title,
                  //     ),
                  //   ),
                  // );
                },
                child: const Text("See more"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
