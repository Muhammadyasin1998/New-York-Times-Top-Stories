import 'package:dio/dio.dart';

abstract class BaseException implements Exception {
  final String message;
  final RequestOptions? requestOptions;

  BaseException({required this.message, this.requestOptions});

  @override
  String toString() => '${runtimeType.toString()}: $message';
}
