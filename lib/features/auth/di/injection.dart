// features/auth/di/injection.dart
import 'package:get_it/get_it.dart';
import 'package:nyt_top_stories/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:nyt_top_stories/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:nyt_top_stories/features/auth/domain/repositories/auth_repository.dart';
import 'package:nyt_top_stories/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'package:nyt_top_stories/features/auth/data/repositories/auth_repository_impl.dart';

import 'package:nyt_top_stories/features/auth/domain/usecases/login_usecase.dart';
import 'package:nyt_top_stories/features/auth/domain/usecases/get_saved_user_usecase.dart';
import 'package:nyt_top_stories/features/auth/domain/usecases/logout_usecase.dart';


import 'package:nyt_top_stories/core/network/i_dio_wrapper.dart';

final sl = GetIt.instance;

Future<void> setupAuthDependencies() async {


  // ✅ Data sources
  sl.registerLazySingleton<IAuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dioWrapper: sl<IDioWrapper>()),
  );

  sl.registerLazySingleton<IAuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sl<SharedPreferences>()),
  );

  // ✅ Repository
  sl.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(
        remote: sl<IAuthRemoteDataSource>(), local: sl<IAuthLocalDataSource>()),
  );

  // ✅ Use cases
  sl.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<IAuthRepository>()));
  sl.registerLazySingleton<GetSavedUserUseCase>(
      () => GetSavedUserUseCase(sl<IAuthRepository>()));
  sl.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(sl<IAuthRepository>()));

  // ✅ Cubit
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: sl<LoginUseCase>(),
      getSavedUserUseCase: sl<GetSavedUserUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );
}
