import 'package:dio/dio.dart';
import 'package:nyt_top_stories/core/error/base_exceptions.dart';

class DataParsingException extends BaseException {
  DataParsingException(
      {required String message, RequestOptions? requestOptions})
      : super(message: message, requestOptions: requestOptions);
}
