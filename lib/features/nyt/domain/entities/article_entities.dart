import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String title;
  final String byline;
  final String abstract;
  final String url;
  final String? thumbnail;
  final String? largeImage;

  const ArticleEntity({
    required this.title,
    required this.byline,
    required this.abstract,
    required this.url,
    this.thumbnail,
    this.largeImage,
  });

  @override
  List<Object?> get props =>
      [title, byline, abstract, url, thumbnail, largeImage];
}
