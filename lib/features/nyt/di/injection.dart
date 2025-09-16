import 'package:get_it/get_it.dart';
import 'package:nyt_top_stories/core/network/i_dio_wrapper.dart';
import 'package:nyt_top_stories/features/nyt/data/datasource/nyt_remote_datasource.dart';
import 'package:nyt_top_stories/features/nyt/data/datasource/nyt_remote_datasource_impl.dart';
import 'package:nyt_top_stories/features/nyt/data/repositories/nyt_repository_impl.dart';
import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';
import 'package:nyt_top_stories/features/nyt/domain/usecases/get_top_stories.dart';
import 'package:nyt_top_stories/features/nyt/presentation/cubit/nyt_cubit.dart';

final sl = GetIt.instance;

Future<void> setupNYTDependencies() async {
  // ✅ Data source
  sl.registerLazySingleton<INYTRemoteDataSource>(
    () => NYTRemoteDataSourceImpl(dioWrapper: sl<IDioWrapper>()),
  );

  // ✅ Repository
  sl.registerLazySingleton<NYTRepository>(
    () => NYTRepositoryImpl(remoteDataSource: sl<INYTRemoteDataSource>()),
  );

  // ✅ Use case
  sl.registerLazySingleton<GetTopStories>(
    () => GetTopStories(sl<NYTRepository>()),
  );

  // ✅ Cubit (injects use case instead of repo directly)
  sl.registerFactory<NYTCubit>(
    () => NYTCubit(getTopStories: sl<GetTopStories>()),
  );
}
