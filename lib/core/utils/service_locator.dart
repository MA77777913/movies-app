import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
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

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => MoviesCubit(sl()));

  sl.registerFactoryParam<MovieDetailsCubit, Movie, void>(
    (initialMovie, _) => MovieDetailsCubit(sl(), sl(), initialMovie: initialMovie),
  );

  sl.registerLazySingleton(() => GetMoviesUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetMovieSuggestionsUseCase(sl()));

  sl.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(sl()));

  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(sl()),
  );

  final dio = Dio();
  sl.registerLazySingleton(() => dio);
  sl.registerLazySingleton(() => MovieApiService(sl()));
}
