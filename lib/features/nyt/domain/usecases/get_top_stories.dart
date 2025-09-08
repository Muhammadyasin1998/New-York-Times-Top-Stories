import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';


import '../repositories/nyt_repository.dart';

class GetTopStories {
  final NYTRepository repository;
  GetTopStories(this.repository);

  Future<List<ArticleEntity>> call(String section) {
    return repository.getTopStories(section);
  }
}
