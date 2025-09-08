import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';



abstract class NYTRepository {
  Future<List<ArticleEntity>> getTopStories(String section);
}
