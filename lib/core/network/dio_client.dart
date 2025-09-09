// lib/core/network/dio_client.dart
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nyt_top_stories/core/error/api_exception.dart';
import 'package:nyt_top_stories/core/error/base_exceptions.dart';
import 'package:nyt_top_stories/core/error/network_exceptions.dart';
import 'package:nyt_top_stories/core/error/unknown_excetpion.dart';

class DioClient {
  final Dio dio;

  DioClient._internal(this.dio);

  factory DioClient() {
    final dio = Dio();

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print('[DIO] → ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          print(
              '[DIO] ← ${response.statusCode} ${response.requestOptions.uri}');
          handler.next(response);
        },
        onError: (err, handler) {
          handler.next(err);
        },
      ),
    );

    return DioClient._internal(dio);
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      _validateResponse(response);
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  void _validateResponse(Response response) {
    if (response.statusCode == null ||
        response.statusCode! < 200 ||
        response.statusCode! >= 300) {
      final msg = response.data is Map ? (response.data['message'] ?? '') : '';
      throw ApiException(
        statusCode: response.statusCode,
        message: 'HTTP Error: ${response.statusCode}. $msg',
        requestOptions: response.requestOptions,
        responseData: response.data,
      );
    }
  }

  BaseException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException(
          message: 'Connection timed out',
          requestOptions: e.requestOptions,
        );
      case DioExceptionType.badResponse:
        return ApiException(
          statusCode: e.response?.statusCode,
          message: e.response?.data is Map
              ? e.response?.data['message'] ?? e.message
              : e.message,
          requestOptions: e.requestOptions,
          responseData: e.response?.data,
        );
      case DioExceptionType.cancel:
        return NetworkException(
          message: 'Request cancelled',
          requestOptions: e.requestOptions,
        );
      case DioExceptionType.unknown:
      default:
        return NetworkException(
          message: e.message ?? 'Unknown network error',
          requestOptions: e.requestOptions,
        );
    }
  }
}
