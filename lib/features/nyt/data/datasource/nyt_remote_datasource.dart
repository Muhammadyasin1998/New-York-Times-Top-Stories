import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nyt_top_stories/core/error/base_exceptions.dart';
import 'package:nyt_top_stories/core/error/data_parsing_exceptions.dart';
import 'package:nyt_top_stories/core/error/unknown_excetpion.dart';
import 'package:nyt_top_stories/core/network/api_endpoints.dart';
import 'package:nyt_top_stories/core/network/dio_client.dart';
import 'package:nyt_top_stories/features/nyt/data/models/article_model.dart';

abstract class NYTRemoteDataSource {
  Future<List<ArticleModel>> fetchTopStories(String section);
}

class NYTRemoteDataSourceImpl implements NYTRemoteDataSource {
  final DioClient dioClient;

  NYTRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<ArticleModel>> fetchTopStories(String section) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      final apiKey = dotenv.env['API_KEY'] ?? '';
      final url = Uri.parse(baseUrl!)
          .resolve(ApiEndpoints.topStoriesSection(section))
          .toString();

      final response = await dioClient.get<Map<String, dynamic>>(
        url,
        queryParameters: {'api-key': apiKey},
      );
      print('Response Data: ${response.data}');

      final data = response.data;

      if (data == null || data is! Map<String, dynamic>) {
        throw DataParsingException(
          message: 'Top-level response is not a JSON object',
          requestOptions: response.requestOptions,
        );
      }

      final results = data['results'];

      return results
          .cast<Map<String, dynamic>>()
          .map<ArticleModel>((json) => _parseArticle(json))
          .toList();
    } on BaseException {
      rethrow;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  ArticleModel _parseArticle(Map<String, dynamic> json) {
    try {
      return ArticleModel.fromJson(json);
    } catch (e) {
      throw DataParsingException(
        message: 'Failed to parse article: $e',
        requestOptions: null,
      );
    }
  }
}
