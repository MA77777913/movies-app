import '../../../movies/domain/entities/movie.dart';
import '../repositories/user_library_repository.dart';

class RecordHistoryUseCase {
  final UserLibraryRepository repository;

  RecordHistoryUseCase(this.repository);

  Future<void> call(Movie movie) => repository.recordInHistory(movie);
}
