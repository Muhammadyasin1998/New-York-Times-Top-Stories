import 'package:dio/dio.dart';
import 'package:nyt_top_stories/core/error/base_exceptions.dart';

class ApiException extends BaseException {
  final int? statusCode;
  final dynamic responseData;

  ApiException({
    this.statusCode,
    required String message,
    this.responseData,
    RequestOptions? requestOptions,
  }) : super(message: message, requestOptions: requestOptions);

  @override
  String toString() =>
      'ApiException(statusCode: $statusCode, message: $message, url: ${requestOptions?.uri})';
}
