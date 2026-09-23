import '../../../movies/domain/entities/movie.dart';

/// The signed-in user's saved movies: the watch list they curate and the
/// history of what they have opened.
abstract class UserLibraryRepository {
  Future<List<Movie>> getWatchlist();

  Future<List<Movie>> getHistory();

  Future<bool> isInWatchlist(int movieId);

  /// Adds the movie if it is absent, removes it if present.
  /// Returns whether the movie is in the watch list afterwards.
  Future<bool> toggleWatchlist(Movie movie);

  /// Records a viewing, refreshing the timestamp if already present.
  Future<void> recordInHistory(Movie movie);
}
