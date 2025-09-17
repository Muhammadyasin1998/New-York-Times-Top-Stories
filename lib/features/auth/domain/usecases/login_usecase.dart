import 'package:dartz/dartz.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/features/auth/domain/repositories/auth_repository.dart';


class LoginUseCase {
  final IAuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, void>> call(String email, String password) {
    return repository.login(email, password);
  }
}
