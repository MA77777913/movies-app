import '../entities/movie.dart';
import '../entities/movie_details.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getMovies({int page = 1, int limit = 20});

  Future<MovieDetails> getMovieDetails({required int movieId});

  Future<List<Movie>> getMovieSuggestions({required int movieId});
}
