import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'package:nyt_top_stories/core/network/dio_client.dart';
import 'package:nyt_top_stories/features/nyt/data/datasource/nyt_remote_datasource.dart';
import 'package:nyt_top_stories/features/nyt/data/repositories/nyt_repository_impl.dart';
import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';
import 'package:nyt_top_stories/features/nyt/presentation/cubit/nyt_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupNYTDependencies() async {
  final dioClient = DioClient();
  final apiKey = dotenv.env['NYT_API_KEY'] ?? '';

  getIt.registerLazySingleton<NYTRemoteDataSource>(
    () => NYTRemoteDataSourceImpl(dioClient: dioClient,),
  );

  getIt.registerLazySingleton<NYTRepository>(
    () => NYTRepositoryImpl(remoteDataSource: getIt<NYTRemoteDataSource>()),
  );

  getIt.registerFactory<NYTCubit>(
    () => NYTCubit(repository: getIt<NYTRepository>()),
  );
}
