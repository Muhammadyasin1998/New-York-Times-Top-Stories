import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final String title;
  final String author;
  final String description;
  final String? thumbnail; // small image
  final String? largeImage; // big image
  final String url; // webview url

  const ArticleEntity({
    required this.title,
    required this.author,
    required this.description,
    required this.thumbnail,
    required this.largeImage,
    required this.url,
  });

  @override
  List<Object?> get props =>
      [title, author, description, thumbnail, largeImage, url];
}
