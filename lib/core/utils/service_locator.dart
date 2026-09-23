import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/movies/data/datasources/movie_api_service.dart';
import '../../features/movies/data/datasources/movie_remote_data_source.dart';
import '../../features/movies/data/repositories/movies_repository_impl.dart';
import '../../features/movies/domain/entities/movie.dart';
import '../../features/movies/domain/repositories/movies_repository.dart';
import '../../features/movies/domain/usecases/get_movie_details_usecase.dart';
import '../../features/movies/domain/usecases/get_movie_suggestions_usecase.dart';
import '../../features/movies/domain/usecases/get_movies_usecase.dart';
import '../../features/movies/presentation/bloc/movie_details_cubit.dart';
import '../../features/movies/presentation/bloc/movies_cubit.dart';
import '../../features/profile/data/datasources/user_library_remote_data_source.dart';
import '../../features/profile/data/repositories/user_library_repository_impl.dart';
import '../../features/profile/domain/repositories/user_library_repository.dart';
import '../../features/profile/domain/usecases/is_in_watchlist_usecase.dart';
import '../../features/profile/domain/usecases/record_history_usecase.dart';
import '../../features/profile/domain/usecases/toggle_watchlist_usecase.dart';
import '../../features/profile/domain/usecases/watch_history_usecase.dart';
import '../../features/profile/domain/usecases/watch_watchlist_usecase.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => MoviesCubit(sl()));

  sl.registerFactory(() => ProfileCubit(sl(), sl(), sl()));

  sl.registerFactoryParam<MovieDetailsCubit, Movie, void>(
    (initialMovie, _) => MovieDetailsCubit(
      sl(),
      sl(),
      sl(),
      sl(),
      sl(),
      initialMovie: initialMovie,
    ),
  );

  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieSuggestionsUseCase(sl()));
  sl.registerLazySingleton(() => WatchWatchlistUseCase(sl()));
  sl.registerLazySingleton(() => WatchHistoryUseCase(sl()));
  sl.registerLazySingleton(() => IsInWatchlistUseCase(sl()));
  sl.registerLazySingleton(() => ToggleWatchlistUseCase(sl()));
  sl.registerLazySingleton(() => RecordHistoryUseCase(sl()));

  sl.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(sl()));

  sl.registerLazySingleton<UserLibraryRepository>(
    () => UserLibraryRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  sl.registerLazySingleton(() => UserLibraryRemoteDataSource());

  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl()),
  );

  final dio = Dio();
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => MovieApiService(sl()));
}
