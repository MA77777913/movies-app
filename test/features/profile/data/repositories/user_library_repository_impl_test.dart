import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/movies/domain/entities/movie.dart';
import 'package:movies_app/features/profile/data/datasources/user_library_remote_data_source.dart';
import 'package:movies_app/features/profile/data/models/saved_movie_model.dart';
import 'package:movies_app/features/profile/data/repositories/user_library_repository_impl.dart';

class _FakeRemoteDataSource implements UserLibraryRemoteDataSource {
  final Map<String, Map<int, SavedMovieModel>> store = {
    UserLibraryRemoteDataSource.watchlistCollection: {},
    UserLibraryRemoteDataSource.historyCollection: {},
  };

  @override
  Future<List<SavedMovieModel>> getSavedMovies(String collection) async {
    return store[collection]!.values.toList();
  }

  @override
  Future<bool> exists(String collection, int movieId) async {
    return store[collection]!.containsKey(movieId);
  }

  @override
  Future<void> save(String collection, SavedMovieModel movie) async {
    store[collection]![movie.id] = movie;
  }

  @override
  Future<void> remove(String collection, int movieId) async {
    store[collection]!.remove(movieId);
  }
}

Movie _movie({int id = 1, String title = 'A Modest Killing'}) =>
    Movie(id: id, title: title, rating: 8.6, mediumCoverImage: 'cover.jpg');

void main() {
  late _FakeRemoteDataSource dataSource;
  late UserLibraryRepositoryImpl repository;

  setUp(() {
    dataSource = _FakeRemoteDataSource();
    repository = UserLibraryRepositoryImpl(dataSource);
  });

  test('toggleWatchlist adds the movie when it is absent', () async {
    final result = await repository.toggleWatchlist(_movie());

    expect(result, isTrue);
    expect(await repository.isInWatchlist(1), isTrue);
    expect(await repository.getWatchlist(), hasLength(1));
  });

  test('toggleWatchlist removes the movie when it is already saved', () async {
    await repository.toggleWatchlist(_movie());

    final result = await repository.toggleWatchlist(_movie());

    expect(result, isFalse);
    expect(await repository.isInWatchlist(1), isFalse);
    expect(await repository.getWatchlist(), isEmpty);
  });

  test('saved movies keep the fields the profile grid renders', () async {
    await repository.toggleWatchlist(_movie());

    final saved = (await repository.getWatchlist()).single;

    expect(saved.id, 1);
    expect(saved.title, 'A Modest Killing');
    expect(saved.rating, 8.6);
    expect(saved.mediumCoverImage, 'cover.jpg');
  });

  test('history keeps one entry per movie when viewed repeatedly', () async {
    await repository.recordInHistory(_movie());
    await repository.recordInHistory(_movie());

    expect(await repository.getHistory(), hasLength(1));
  });

  test('watch list and history are stored separately', () async {
    await repository.toggleWatchlist(_movie(id: 1));
    await repository.recordInHistory(_movie(id: 2, title: 'Killing Jesus'));

    expect((await repository.getWatchlist()).single.id, 1);
    expect((await repository.getHistory()).single.id, 2);
  });
}
