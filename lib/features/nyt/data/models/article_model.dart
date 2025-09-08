

import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';

class ArticleModel extends ArticleEntity {
  const ArticleModel({
    required String title,
    required String author,
    required String description,
    required String? thumbnail,
    required String? largeImage,
    required String url,
  }) : super(
          title: title,
          author: author,
          description: description,
          thumbnail: thumbnail,
          largeImage: largeImage,
          url: url,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    // NYT API has `multimedia` array for images
    String? thumb;
    String? large;

    if (json['multimedia'] != null) {
      final List media = json['multimedia'];
      if (media.isNotEmpty) {
        // try to pick small + large images from array
        thumb = media.length > 0 ? media[0]['url'] as String? : null;
        large = media.length > 1 ? media[1]['url'] as String? : null;
      }
    }

    return ArticleModel(
      title: json['title'] ?? '',
      author: json['byline'] ?? '',
      description: json['abstract'] ?? '',
      thumbnail: thumb,
      largeImage: large,
      url: json['url'] ?? '',
    );
  }
}
