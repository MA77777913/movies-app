import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/movies/domain/entities/movie.dart';
import 'package:movies_app/features/movies/domain/entities/movie_details.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movie_suggestions_usecase.dart';
import 'package:movies_app/features/movies/presentation/bloc/movie_details_cubit.dart';
import 'package:movies_app/features/movies/presentation/bloc/movie_details_state.dart';
import 'package:movies_app/features/profile/domain/repositories/user_library_repository.dart';
import 'package:movies_app/features/profile/domain/usecases/is_in_watchlist_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/record_history_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/toggle_watchlist_usecase.dart';

class _FakeUserLibraryRepository implements UserLibraryRepository {
  bool saved = false;
  Object? failure;
  final recordedHistory = <Movie>[];

  @override
  Stream<List<Movie>> watchWatchlist() => const Stream.empty();

  @override
  Stream<List<Movie>> watchHistory() => const Stream.empty();

  @override
  Future<bool> isInWatchlist(int movieId) async {
    if (failure != null) throw failure!;
    return saved;
  }

  @override
  Future<bool> toggleWatchlist(Movie movie) async {
    if (failure != null) throw failure!;
    saved = !saved;
    return saved;
  }

  @override
  Future<void> recordInHistory(Movie movie) async {
    if (failure != null) throw failure!;
    recordedHistory.add(movie);
  }
}

class _FakeMoviesRepository implements MoviesRepository {
  MovieDetails? detailsToReturn;
  Object? detailsError;
  List<Movie> suggestionsToReturn = const [];
  Object? suggestionsError;

  @override
  Future<List<Movie>> getMovies({int page = 1, int limit = 20}) async => [];

  @override
  Future<MovieDetails> getMovieDetails({required int movieId}) async {
    if (detailsError != null) throw detailsError!;
    return detailsToReturn!;
  }

  @override
  Future<List<Movie>> getMovieSuggestions({required int movieId}) async {
    if (suggestionsError != null) throw suggestionsError!;
    return suggestionsToReturn;
  }
}

Movie _initialMovie() => Movie(id: 78513, title: 'A Modest Killing');

void main() {
  late _FakeMoviesRepository repository;
  late _FakeUserLibraryRepository library;

  setUp(() {
    repository = _FakeMoviesRepository();
    library = _FakeUserLibraryRepository();
  });

  MovieDetailsCubit buildCubit() {
    return MovieDetailsCubit(
      GetMovieDetailsUseCase(repository),
      GetMovieSuggestionsUseCase(repository),
      IsInWatchlistUseCase(library),
      ToggleWatchlistUseCase(library),
      RecordHistoryUseCase(library),
      initialMovie: _initialMovie(),
    );
  }

  test('initial state carries the tapped movie so a title/background can show immediately', () {
    final cubit = buildCubit();
    expect(cubit.state.status, MovieDetailsStatus.initial);
    expect(cubit.state.initialMovie.title, 'A Modest Killing');
  });

  test('loadDetails emits loading then loaded with details and suggestions', () async {
    repository.detailsToReturn = MovieDetails(id: 78513, title: 'A Modest Killing', likeCount: 1, runtime: 82);
    repository.suggestionsToReturn = [Movie(id: 1768, title: 'Killing Jesus')];

    final cubit = buildCubit();
    // emit(loading) happens synchronously before the first await, so this is
    // already true the instant loadDetails() is called, before it resolves.
    final pending = cubit.loadDetails();
    expect(cubit.state.status, MovieDetailsStatus.loading);

    await pending;

    expect(cubit.state.status, MovieDetailsStatus.loaded);
    expect(cubit.state.details?.likeCount, 1);
    expect(cubit.state.suggestions.single.title, 'Killing Jesus');
  });

  test('loadDetails records the visit in history and reflects watch list state', () async {
    repository.detailsToReturn = MovieDetails(id: 78513, title: 'A Modest Killing');
    library.saved = true;

    final cubit = buildCubit();
    await cubit.loadDetails();

    expect(library.recordedHistory.single.id, 78513);
    expect(cubit.state.isInWatchlist, isTrue);
  });

  test('a failing library leaves the movie data intact', () async {
    repository.detailsToReturn = MovieDetails(id: 78513, title: 'A Modest Killing');
    library.failure = Exception('firestore down');

    final cubit = buildCubit();
    await cubit.loadDetails();

    // The details still loaded; only the watch list flag is unavailable.
    expect(cubit.state.status, MovieDetailsStatus.loaded);
    expect(cubit.state.isInWatchlist, isFalse);
  });

  test('toggleWatchlist flips the flag and persists it', () async {
    final cubit = buildCubit();

    await cubit.toggleWatchlist();
    expect(cubit.state.isInWatchlist, isTrue);
    expect(library.saved, isTrue);

    await cubit.toggleWatchlist();
    expect(cubit.state.isInWatchlist, isFalse);
    expect(library.saved, isFalse);
  });

  test('toggleWatchlist rolls back when the write fails', () async {
    library.failure = Exception('offline');

    final cubit = buildCubit();
    await cubit.toggleWatchlist();

    expect(cubit.state.isInWatchlist, isFalse);
  });

  test('loadDetails emits error when the details fetch fails, preserving the initial movie', () async {
    repository.detailsError = Exception('boom');
    repository.suggestionsToReturn = [];

    final cubit = buildCubit();
    final pending = cubit.loadDetails();
    expect(cubit.state.status, MovieDetailsStatus.loading);

    await pending;

    expect(cubit.state.status, MovieDetailsStatus.error);
    expect(cubit.state.errorMessage, contains('boom'));
    expect(cubit.state.initialMovie.title, 'A Modest Killing');
  });
}
