import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/movies/domain/entities/movie.dart';
import 'package:movies_app/features/profile/data/datasources/user_library_remote_data_source.dart';
import 'package:movies_app/features/profile/data/models/saved_movie_model.dart';
import 'package:movies_app/features/profile/data/repositories/user_library_repository_impl.dart';

/// Stands in for Firestore: writes land in a map and every change is pushed
/// down the matching stream, the way snapshots() behaves.
class _FakeRemoteDataSource implements UserLibraryRemoteDataSource {
  final Map<String, Map<int, SavedMovieModel>> store = {
    UserLibraryRemoteDataSource.watchlistCollection: {},
    UserLibraryRemoteDataSource.historyCollection: {},
  };

  final Map<String, StreamController<List<SavedMovieModel>>> _controllers = {
    UserLibraryRemoteDataSource.watchlistCollection:
        StreamController<List<SavedMovieModel>>.broadcast(),
    UserLibraryRemoteDataSource.historyCollection:
        StreamController<List<SavedMovieModel>>.broadcast(),
  };

  @override
  Stream<List<SavedMovieModel>> watchSavedMovies(String collection) {
    return _controllers[collection]!.stream;
  }

  @override
  Future<bool> exists(String collection, int movieId) async {
    return store[collection]!.containsKey(movieId);
  }

  @override
  Future<void> save(String collection, SavedMovieModel movie) async {
    store[collection]![movie.id] = movie;
    _emit(collection);
  }

  @override
  Future<void> remove(String collection, int movieId) async {
    store[collection]!.remove(movieId);
    _emit(collection);
  }

  void _emit(String collection) {
    _controllers[collection]!.add(store[collection]!.values.toList());
  }

  Future<void> dispose() async {
    for (final controller in _controllers.values) {
      await controller.close();
    }
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

  tearDown(() => dataSource.dispose());

  test('toggleWatchlist adds the movie when it is absent', () async {
    final result = await repository.toggleWatchlist(_movie());

    expect(result, isTrue);
    expect(await repository.isInWatchlist(1), isTrue);
  });

  test('toggleWatchlist removes the movie when it is already saved', () async {
    await repository.toggleWatchlist(_movie());

    final result = await repository.toggleWatchlist(_movie());

    expect(result, isFalse);
    expect(await repository.isInWatchlist(1), isFalse);
  });

  test('the watch list stream emits the saved movies as they change', () async {
    final emitted = <List<Movie>>[];
    final sub = repository.watchWatchlist().listen(emitted.add);

    await repository.toggleWatchlist(_movie());
    await repository.toggleWatchlist(_movie(id: 2, title: 'Killing Jesus'));
    await Future<void>.delayed(Duration.zero);

    expect(emitted.last.map((m) => m.id), [1, 2]);
    await sub.cancel();
  });

  test('saved movies keep the fields the profile grid renders', () async {
    final emitted = <List<Movie>>[];
    final sub = repository.watchWatchlist().listen(emitted.add);

    await repository.toggleWatchlist(_movie());
    await Future<void>.delayed(Duration.zero);

    final saved = emitted.last.single;
    expect(saved.id, 1);
    expect(saved.title, 'A Modest Killing');
    expect(saved.rating, 8.6);
    expect(saved.mediumCoverImage, 'cover.jpg');
    await sub.cancel();
  });

  test('history keeps one entry per movie when viewed repeatedly', () async {
    final emitted = <List<Movie>>[];
    final sub = repository.watchHistory().listen(emitted.add);

    await repository.recordInHistory(_movie());
    await repository.recordInHistory(_movie());
    await Future<void>.delayed(Duration.zero);

    expect(emitted.last, hasLength(1));
    await sub.cancel();
  });

  test('watch list and history are stored separately', () async {
    final watchlist = <List<Movie>>[];
    final history = <List<Movie>>[];
    final subA = repository.watchWatchlist().listen(watchlist.add);
    final subB = repository.watchHistory().listen(history.add);

    await repository.toggleWatchlist(_movie(id: 1));
    await repository.recordInHistory(_movie(id: 2, title: 'Killing Jesus'));
    await Future<void>.delayed(Duration.zero);

    expect(watchlist.last.single.id, 1);
    expect(history.last.single.id, 2);
    await subA.cancel();
    await subB.cancel();
  });
}
