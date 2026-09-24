import '../../../movies/domain/entities/movie.dart';
import '../repositories/user_library_repository.dart';

class WatchHistoryUseCase {
  final UserLibraryRepository repository;

  WatchHistoryUseCase(this.repository);

  Stream<List<Movie>> call() => repository.watchHistory();
}
