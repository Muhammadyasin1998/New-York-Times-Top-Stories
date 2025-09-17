import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nyt_top_stories/core/error/failure.dart';
import 'package:nyt_top_stories/core/services/network_connectivity_service.dart';

abstract class IDioWrapper {
  Future<Response<dynamic>> onPost({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onPostImageData(
      {required String api, required String data, String? key});

  Future<Response<dynamic>> onPatch(
      {required String api,
      required dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers});

  Future<Response<dynamic>> onPut({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onGet({
    required String api,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isPullToRefresh = false,
  });

  Future<Response<dynamic>> onDelete({
    required String api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  void onCancel();

  Future<String> downloadFile(String path);
}
