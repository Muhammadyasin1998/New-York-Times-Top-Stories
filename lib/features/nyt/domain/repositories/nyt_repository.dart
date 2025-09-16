import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/error/failure.dart';

import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';

abstract class NYTRepository {
  Future<Either<Failure, List<ArticleEntity>>> getTopStories(String section);
}
