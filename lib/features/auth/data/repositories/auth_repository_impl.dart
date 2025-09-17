// features/auth/data/repositories/auth_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:nyt_top_stories/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:nyt_top_stories/features/auth/domain/entities/user_entity.dart';
import 'package:nyt_top_stories/features/auth/domain/repositories/auth_repository.dart';

import 'package:nyt_top_stories/features/auth/data/models/user_model.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource remote;
  final IAuthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    final response = await remote.login(email, password);
    return response.fold(
      (failure) => Left(failure),
      (data) async {
        final token = data["token"];
        final user = UserModel.fromJson(data["user"]);
        await local.saveToken(token);
        await local.saveUser(user);
        return const Right(null);
      },
    );
  }

  @override
  Future<Either<Failure, UserEntity?>> getSavedUser() async {
    try {
      final user = await local.getUser();
      return Right(user);
    } catch (e) {
      return Left(CustomFailure("Failed to load user: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await local.clear();
      return const Right(null);
    } catch (e) {
      return Left(CustomFailure("Logout failed: $e"));
    }
  }
}
