
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/features/nyt/data/datasource/nyt_remote_datasource.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';
import 'package:dartz/dartz.dart';

class NYTRepositoryImpl implements NYTRepository {
  final INYTRemoteDataSource remoteDataSource;

  NYTRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> getTopStories(String section) {
    return remoteDataSource.fetchTopStories(section);
  }
}
