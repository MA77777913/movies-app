import '../entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getMovies({int page = 1, int limit = 20});
}
