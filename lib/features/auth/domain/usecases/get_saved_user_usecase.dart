import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/features/auth/domain/entities/user_entity.dart';
import 'package:nyt_top_stories/features/auth/domain/repositories/auth_repository.dart';


class GetSavedUserUseCase {
  final IAuthRepository repository;

  GetSavedUserUseCase(this.repository);

  Future<Either<Failure, UserEntity?>> call() {
    return repository.getSavedUser();
  }
}
