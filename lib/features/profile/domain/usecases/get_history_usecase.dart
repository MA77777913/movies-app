import '../../../movies/domain/entities/movie.dart';
import '../repositories/user_library_repository.dart';

class GetHistoryUseCase {
  final UserLibraryRepository repository;

  GetHistoryUseCase(this.repository);

  Future<List<Movie>> call() => repository.getHistory();
}
