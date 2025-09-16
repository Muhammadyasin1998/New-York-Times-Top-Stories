import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/error/failure.dart';

import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';

class GetTopStories {
  final NYTRepository repository;

  GetTopStories(this.repository);

  Future<Either<Failure, List<ArticleEntity>>> call(String section) {
    return repository.getTopStories(section);
  }
}
