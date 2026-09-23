import '../../../movies/domain/entities/movie.dart';
import '../../domain/repositories/user_library_repository.dart';
import '../datasources/user_library_remote_data_source.dart';
import '../models/saved_movie_model.dart';

class UserLibraryRepositoryImpl implements UserLibraryRepository {
  final UserLibraryRemoteDataSource remoteDataSource;

  UserLibraryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> getWatchlist() async {
    final saved = await remoteDataSource
        .getSavedMovies(UserLibraryRemoteDataSource.watchlistCollection);
    return saved.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Movie>> getHistory() async {
    final saved = await remoteDataSource
        .getSavedMovies(UserLibraryRemoteDataSource.historyCollection);
    return saved.map((m) => m.toEntity()).toList();
  }

  @override
  Future<bool> isInWatchlist(int movieId) {
    return remoteDataSource.exists(
      UserLibraryRemoteDataSource.watchlistCollection,
      movieId,
    );
  }

  @override
  Future<bool> toggleWatchlist(Movie movie) async {
    const collection = UserLibraryRemoteDataSource.watchlistCollection;
    final alreadySaved = await remoteDataSource.exists(collection, movie.id);
    if (alreadySaved) {
      await remoteDataSource.remove(collection, movie.id);
      return false;
    }
    await remoteDataSource.save(collection, SavedMovieModel.fromMovie(movie));
    return true;
  }

  @override
  Future<void> recordInHistory(Movie movie) {
    return remoteDataSource.save(
      UserLibraryRemoteDataSource.historyCollection,
      SavedMovieModel.fromMovie(movie),
    );
  }
}
