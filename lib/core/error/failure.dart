/// lib/core/error/failures.dart
abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class CustomFailure extends Failure {
  CustomFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure() : super('Server Failure');
}

class ResourceNotFound extends Failure {
  ResourceNotFound() : super('Not Found Failure');
}

class NoInternetFailure extends Failure {
  NoInternetFailure() : super("No internet connection");
}

class AuthorizationFailure extends Failure {
  AuthorizationFailure() : super('Authorization Failure');
}

class DioBadRequest extends Failure {
  DioBadRequest({required String message}) : super(message);
}

class DioUnAuthorized extends Failure {
  DioUnAuthorized({required String message}) : super(message);
}

class DioNotFoundError extends Failure {
  DioNotFoundError({required String message}) : super(message);
}

class DioTimeoutError extends Failure {
  DioTimeoutError({required String message}) : super(message);
}

class ServiceUnavailableFailure extends Failure {
  ServiceUnavailableFailure({required String message}) : super(message);
}

class DioDefaultFailure extends Failure {
  DioDefaultFailure({required String message}) : super(message);
}

class DeleteAccountFailure extends Failure {
  DeleteAccountFailure({required String message}) : super(message);
}

class LogOutAccountFailure extends Failure {
  LogOutAccountFailure({required String message}) : super(message);
}

class SslCertificateError extends Failure {
  SslCertificateError() : super("SSL Certificate Error [Expired]");
}
