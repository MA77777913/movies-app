import '../../domain/entities/movie.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MovieRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getMovies({int page = 1, int limit = 20}) async {
    final response = await remoteDataSource.getMovies(page: page, limit: limit);
    return response.data.movies?.map((m) => m.toEntity()).toList() ?? [];
  }
}
