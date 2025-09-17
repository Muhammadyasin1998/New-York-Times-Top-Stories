import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/features/auth/domain/repositories/auth_repository.dart';


class LogoutUseCase {
  final IAuthRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.logout();
  }
}
