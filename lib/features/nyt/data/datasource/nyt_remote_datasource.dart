import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nyt_top_stories/features/nyt/data/models/article_model.dart';

abstract class NYTRemoteDataSource {
  Future<List<ArticleModel>> fetchTopStories(String section);
}

class NYTRemoteDataSourceImpl implements NYTRemoteDataSource {
  final Dio dio;

  NYTRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ArticleModel>> fetchTopStories(String section) async {
    try {
      // Full endpoint with section and API key directly
      print('Fetching top stories for section: $section');
      final apiKey = 'ZuW4Fhr2Dqv1IXsgtDFYk4ZaSdnJmD5y';
      final url =
          "https://api.nytimes.com/svc/topstories/v2/arts.json?api-key=$apiKey";

      final response = await dio.get(url);
      print('Response status: ${response}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>;
        return results
            .map((r) => ArticleModel.fromJson(r as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load top stories: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
