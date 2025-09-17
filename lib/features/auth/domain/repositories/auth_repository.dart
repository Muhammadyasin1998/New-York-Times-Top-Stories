// features/auth/domain/repositories/i_auth_repository.dart
import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/features/auth/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, UserEntity?>> getSavedUser();
  Future<Either<Failure, void>> logout();
}
