import '../../../movies/domain/entities/movie.dart';
import '../repositories/user_library_repository.dart';

class GetWatchlistUseCase {
  final UserLibraryRepository repository;

  GetWatchlistUseCase(this.repository);

  Future<List<Movie>> call() => repository.getWatchlist();
}
