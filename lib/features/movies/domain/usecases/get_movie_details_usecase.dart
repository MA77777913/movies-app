import '../entities/movie_details.dart';
import '../repositories/movies_repository.dart';

class GetMovieDetailsUseCase {
  final MoviesRepository repository;

  GetMovieDetailsUseCase(this.repository);

  Future<MovieDetails> call({required int movieId}) {
    return repository.getMovieDetails(movieId: movieId);
  }
}
