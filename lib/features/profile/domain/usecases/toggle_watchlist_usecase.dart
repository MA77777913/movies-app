import '../../../movies/domain/entities/movie.dart';
import '../repositories/user_library_repository.dart';

class ToggleWatchlistUseCase {
  final UserLibraryRepository repository;

  ToggleWatchlistUseCase(this.repository);

  Future<bool> call(Movie movie) => repository.toggleWatchlist(movie);
}
