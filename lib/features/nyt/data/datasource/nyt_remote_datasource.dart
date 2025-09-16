import 'package:dartz/dartz.dart';

import 'package:nyt_top_stories/core/error/failure.dart';



import 'package:nyt_top_stories/features/nyt/data/models/article_model.dart';



abstract class INYTRemoteDataSource {
  Future<Either<Failure, List<ArticleModel>>> fetchTopStories(String section);
}
