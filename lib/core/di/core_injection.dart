import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nyt_top_stories/core/network/i_dio_wrapper.dart';
import 'package:nyt_top_stories/core/network/i_dop_wrapper_impl.dart';
import 'package:nyt_top_stories/core/services/network_connectivity_service.dart';
import 'package:shared_preferences/shared_preferences.dart';



final sl = GetIt.instance;

Future<void> initDependencies() async {


  // Network info
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfoImpl(sl()));
  // ✅ SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Dio
  final dio = Dio(
    BaseOptions(
      // baseUrl: sl<EnvService>().baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      listFormat: ListFormat.multi,
    ),
  );

  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));

  dio.interceptors.addAll([
    // DioTokenIterceptor(),
    // AppVersionInterceptor(),
  ]);

  sl.registerLazySingleton<Dio>(() => dio);

  sl.registerLazySingleton<IDioWrapper>(
    () => DioWrapperImp(sl(), sl<INetworkInfo>()),
  );
}
