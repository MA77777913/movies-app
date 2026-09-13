import '../entities/movie.dart';
import '../repositories/movies_repository.dart';

class GetMovieSuggestionsUseCase {
  final MoviesRepository repository;

  GetMovieSuggestionsUseCase(this.repository);

  Future<List<Movie>> call({required int movieId}) {
    return repository.getMovieSuggestions(movieId: movieId);
  }
}
