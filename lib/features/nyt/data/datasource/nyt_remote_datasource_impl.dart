import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/core/network/api_endpoints.dart';
import 'package:nyt_top_stories/core/network/i_dio_wrapper.dart';
import 'package:nyt_top_stories/features/nyt/data/datasource/nyt_remote_datasource.dart';

import 'package:nyt_top_stories/features/nyt/data/models/article_model.dart';

import 'package:dartz/dartz.dart';

class NYTRemoteDataSourceImpl implements INYTRemoteDataSource {
  final IDioWrapper dioWrapper;

  NYTRemoteDataSourceImpl({required this.dioWrapper});

  @override
  Future<Either<Failure, List<ArticleModel>>> fetchTopStories(
      String section) async {
    try {
      final baseUrl = dotenv.env['BASE_URL'];
      final apiKey = dotenv.env['API_KEY'] ?? '';

      final url = Uri.parse(baseUrl!)
          .resolve(ApiEndpoints.topStoriesSection(section))
          .toString();

      final result = await dioWrapper.onGet(
        api: url,
        queryParameters: {'api-key': apiKey},
      );

      if (result.data == null || result.data['results'] == null) {
        return Left(CustomFailure("Invalid response from server"));
      }

      final list = (result.data['results'] as List).map((raw) {
        return ArticleModel.fromJson(raw);
      }).toList();

      return Right(list);
    } catch (e) {
      if (e is Failure) {
        return Left(e);
      } else {
        return Left(CustomFailure("Unexpected error: $e"));
      }
    }
  }
}
