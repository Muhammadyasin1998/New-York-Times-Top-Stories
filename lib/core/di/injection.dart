import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:nyt_top_stories/core/network/i_dio_wrapper.dart';
import 'package:nyt_top_stories/core/services/network_connectivity_service.dart';



final sl = GetIt.instance;

Future<void> initDependencies() async {
  // await APICall.storeGuestuser("false");

  // // Navigation
  // sl.registerLazySingleton<INavigator>(() => NavigatorImpl());

  // Network info
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<INetworkInfo>(() => NetworkInfoImpl(sl()));

  // App metadata
  // final appMetadataService = AppMetadataService();
  // await appMetadataService.init();
  // sl.registerLazySingleton<AppMetadataService>(() => appMetadataService);

  // Env
  try {
    // final envService = EnvService();
    // await envService.init();
    // sl.registerLazySingleton<EnvService>(() => envService);

    // Constants2.initialize(
    //   baseUrl: envService.baseUrl,
    //   baseUrlEndpointOnly: envService.baseUrlEndPointOnly,
    // );
  } catch (e) {
    debugPrint("Error in init [ENV SERVICE]: $e");
  }

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

  // Local Storage
  try {
    // final localStorageService = LocalStorageService();
    // await localStorageService.init();
    // sl.registerLazySingleton<LocalStorageService>(() => localStorageService);

    // sl.registerLazySingleton<AuthService>(
    //   () => AuthService(localStorageService: sl()),
    // );
  } catch (e) {
    debugPrint("Error in init [LOCAL STORAGE SERVICE]: $e");
  }

  // Secure storage
  try {
    // sl.registerLazySingleton<SecureStorageService>(
    //     () => SecureStorageService());
  } catch (e) {
    debugPrint("Error in init [SECURE STORAGE SERVICE]: $e");
  }

  // Notifications
  try {
    // final localNotificationService = LocalNotificationService();
    // await localNotificationService.init();
    // sl.registerLazySingleton<LocalNotificationService>(
    //   () => localNotificationService,
    // );
  } catch (e) {
    debugPrint("Error in init [LOCAL NOTIFICATIONS]: $e");
  }

  // Repositories
  // sl.registerLazySingleton<IUserRepository>(
  //   () => UserRepositoryImp(dioWrapper: sl()),
  // );

  // sl.registerLazySingleton<UserController>(
  //   () => UserController(
  //     navigator: sl<INavigator>(),
  //     userRepository: sl<IUserRepository>(),
  //   ),
  // );

  // sl.registerLazySingleton<IHostLiveRepository>(
  //   () => HostLiveRepositoryImp(sl()),
  // );

  // sl.registerLazySingleton<INewPostRepository>(
  //   () => NewPostRepositoryImp(sl<IDioWrapper>()),
  // );

  // sl.registerLazySingleton<IChatRepository>(
  //   () => ChatRepositoryImp(sl<IDioWrapper>()),
  // );

  // sl.registerLazySingleton<INewPickLocationRepository>(
  //   () => NewPickLocationRepositoryImp(sl<IDioWrapper>()),
  // );
}
