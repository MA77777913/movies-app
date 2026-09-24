import '../repositories/user_library_repository.dart';

class IsInWatchlistUseCase {
  final UserLibraryRepository repository;

  IsInWatchlistUseCase(this.repository);

  Future<bool> call(int movieId) => repository.isInWatchlist(movieId);
}
