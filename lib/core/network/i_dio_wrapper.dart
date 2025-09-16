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

class DioWrapperImp implements IDioWrapper {
  final Dio _dio;
  final INetworkInfo _networkInfo;

  DioWrapperImp(this._dio, this._networkInfo);

  dynamic _processResponse(Response<dynamic> response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response;
    } else {
      throw _mapDioError(response);
    }
  }

  Failure _mapDioError(Response<dynamic> response) {
    debugPrint("Response _mapDioError: ${response.data}");
    debugPrint("Response statuscode: ${response.statusCode}");
    if (response.statusCode == 503) {
      return ServiceUnavailableFailure(
        message: response.data['error'] ?? "Service Unavailable",
      );
    }

    switch (response.statusCode) {
      case 400:
        return DioBadRequest(
            message: response.data['message'] ??
                response.data['error'] ??
                "Bad Request");
      case 401:
        return DioUnAuthorized(
            message: response.data['message'] ??
                response.data['error'] ??
                "Unauthorized Request");
      case 404:
        return DioNotFoundError(
            message: response.data['message'] ??
                response.data['error'] ??
                "Resource Not Found");
      case 408:
        return DioTimeoutError(
            message: response.data['message'] ??
                response.data['error'] ??
                "Request Timeout");
      case 500:
        return ServerFailure();
      case 503:
        return ServiceUnavailableFailure(
          message: response.data['error'] ?? "Service Unavailable",
        );
      default:
        return DioDefaultFailure(message: "Unknown Error");
    }
  }

  bool _isSslCertificateError(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.badCertificate ||
        err.message?.contains('bad certificate') == true ||
        err.message?.contains('certificate') == true ||
        err.message?.contains('SSL') == true ||
        err.message?.contains('TLS') == true ||
        err.message?.contains('handshake') == true ||
        err.message?.contains('certificate verification') == true;
  }

  @override
  Future<Response<dynamic>> onPost({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (!(await _networkInfo.isConnected)) {
        debugPrint("onPost not internet");
        throw NoInternetFailure();
      }

      final response = await _dio.post(
        api,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _processResponse(response);
    } on DioException catch (err) {
      if (_isSslCertificateError(err)) {
        throw SslCertificateError();
      }

      throw _mapDioError(err.response!);
    }
  }

  @override
  Future<Response<dynamic>> onPostImageData({
    required String api,
    required String data,
    String? key,
  }) async {
    try {
      if (!(await _networkInfo.isConnected)) {
        throw NoInternetFailure();
      }

      final formData = FormData.fromMap({
        key ?? 'file': await MultipartFile.fromFile(data),
      });
      final response = await _dio.post(api, data: formData);
      return _processResponse(response);
    } on DioException catch (err) {
      if (_isSslCertificateError(err)) {
        throw SslCertificateError();
      }

      throw _mapDioError(err.response!);
    }
  }

  @override
  Future<Response<dynamic>> onPatch({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (!(await _networkInfo.isConnected)) {
        throw NoInternetFailure();
      }

      final response = await _dio.patch(
        api,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _processResponse(response);
    } on DioException catch (err) {
      if (_isSslCertificateError(err)) {
        throw SslCertificateError();
      }

      throw _mapDioError(err.response!);
    }
  }

  @override
  Future<Response<dynamic>> onPut({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (!(await _networkInfo.isConnected)) {
        throw NoInternetFailure();
      }

      final response = await _dio.put(
        api,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _processResponse(response);
    } on DioException catch (err) {
      if (_isSslCertificateError(err)) {
        throw SslCertificateError();
      }

      throw _mapDioError(err.response!);
    }
  }

  @override
  Future<Response<dynamic>> onGet({
    required String api,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isPullToRefresh = false,
  }) async {
    try {
      if (!(await _networkInfo.isConnected)) {
        throw NoInternetFailure();
      }

      final response = await _dio.get(
        api,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          contentType: Headers.jsonContentType,
        ),
      );
      return _processResponse(response);
    } on DioException catch (err) {
      if (_isSslCertificateError(err)) {
        throw SslCertificateError();
      }

      throw _mapDioError(err.response!);
    }
  }

  @override
  void onCancel() {
    _dio.close(force: true);
  }

  @override
  Future<String> downloadFile(String path) async {
    try {
      if (!(await _networkInfo.isConnected)) {
        throw NoInternetFailure();
      }

      final response = await _dio.download(
        path,
        "downloaded_file",
      );
      if (response.statusCode == 200) {
        return "File downloaded successfully.";
      } else {
        throw Exception("Failed to download file: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> onDelete({
    required String api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      if (!(await _networkInfo.isConnected)) {
        throw NoInternetFailure();
      }

      final response = await _dio.delete(
        api,
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: data,
      );
      return _processResponse(response);
    } on DioException catch (err) {
      if (_isSslCertificateError(err)) {
        throw SslCertificateError();
      }

      throw _mapDioError(err.response!);
    }
  }
}
