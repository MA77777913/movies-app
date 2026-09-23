import '../../../movies/domain/entities/movie.dart';
import '../repositories/user_library_repository.dart';

class WatchWatchlistUseCase {
  final UserLibraryRepository repository;

  WatchWatchlistUseCase(this.repository);

  Stream<List<Movie>> call() => repository.watchWatchlist();
}
