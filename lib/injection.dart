import 'package:get_it/get_it.dart';
import 'package:study_case/data/datasources/post_remote_data_source.dart';
import 'package:study_case/data/repositories/post_repository_impl.dart';
import 'package:study_case/domain/repositories/post_repository.dart';
import 'package:study_case/domain/usecases/get_list_post.dart';
import 'package:study_case/presentation/bloc/post_bloc.dart';
import 'package:study_case/utils/ssl_pinning.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => PostBloc(locator()));
  locator.registerLazySingleton(() => GetListPost(locator()));
  locator.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton(() => SSLPinning.client);
}
