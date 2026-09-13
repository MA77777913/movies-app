import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';
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

  @override
  Future<MovieDetails> getMovieDetails({required int movieId}) async {
    final response = await remoteDataSource.getMovieDetails(movieId: movieId);
    return response.data.movie.toEntity();
  }

  @override
  Future<List<Movie>> getMovieSuggestions({required int movieId}) async {
    final response = await remoteDataSource.getMovieSuggestions(movieId: movieId);
    return response.data.movies?.map((m) => m.toEntity()).toList() ?? [];
  }
}
