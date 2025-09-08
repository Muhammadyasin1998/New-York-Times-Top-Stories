

import 'package:nyt_top_stories/features/nyt/data/datasource/nyt_remote_datasource.dart';
import 'package:nyt_top_stories/features/nyt/data/models/article_model.dart';
import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';


class NYTRepositoryImpl implements NYTRepository {
  final NYTRemoteDataSource remoteDataSource;
  NYTRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ArticleModel>> getTopStories(String section) {
    return remoteDataSource.fetchTopStories(section);
  }
}
