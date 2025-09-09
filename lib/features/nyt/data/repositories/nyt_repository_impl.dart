import 'package:nyt_top_stories/features/nyt/data/datasource/nyt_remote_datasource.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';

class NYTRepositoryImpl implements NYTRepository {
  final NYTRemoteDataSource remoteDataSource;

  NYTRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ArticleEntity>> getTopStories(String section) async {
    final articles = await remoteDataSource.fetchTopStories(section);
    return articles;
  }
}
