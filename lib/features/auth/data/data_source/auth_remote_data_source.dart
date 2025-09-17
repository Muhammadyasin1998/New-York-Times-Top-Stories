import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/config/env_config.dart';
import 'package:nyt_top_stories/core/network/api_endpoints.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/core/network/i_dio_wrapper.dart';
import 'package:nyt_top_stories/features/auth/data/models/user_model.dart';

abstract class IAuthRemoteDataSource {
  Future<Either<Failure, Map<String, dynamic>>> login(
      String email, String password);
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final IDioWrapper dioWrapper;

  AuthRemoteDataSourceImpl({required this.dioWrapper});

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
      String email, String password) async {
    try {
      final url =
          Uri.parse(EnvConfig.baseUrl).resolve(ApiEndpoints.login).toString();

      final result = await dioWrapper.onPost(
        api: url,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (result.data == null) {
        return Left(CustomFailure("Invalid response from server"));
      }

      return Right(result.data);
    } catch (e) {
      return Left(CustomFailure("Login failed: $e"));
    }
  }
}
