import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/utils/service_locator.dart' as di;
import 'package:movies_app/features/movies/domain/entities/movie.dart';
import 'package:movies_app/features/movies/domain/entities/movie_details.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movie_suggestions_usecase.dart';
import 'package:movies_app/features/movies/presentation/bloc/movie_details_cubit.dart';
import 'package:movies_app/features/movies/presentation/pages/movie_details_screen.dart';
import 'package:movies_app/features/profile/domain/repositories/user_library_repository.dart';
import 'package:movies_app/features/profile/domain/usecases/is_in_watchlist_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/record_history_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/toggle_watchlist_usecase.dart';

/// Holds both calls open so the screen can be inspected mid-load.
class _PendingRepository implements MoviesRepository {
  final detailsCompleter = Completer<MovieDetails>();
  final suggestionsCompleter = Completer<List<Movie>>();

  @override
  Future<List<Movie>> getMovies({int page = 1, int limit = 20}) async => [];

  @override
  Future<MovieDetails> getMovieDetails({required int movieId}) =>
      detailsCompleter.future;

  @override
  Future<List<Movie>> getMovieSuggestions({required int movieId}) =>
      suggestionsCompleter.future;
}

class _EmptyUserLibraryRepository implements UserLibraryRepository {
  @override
  Stream<List<Movie>> watchWatchlist() => const Stream.empty();

  @override
  Stream<List<Movie>> watchHistory() => const Stream.empty();

  @override
  Future<bool> isInWatchlist(int movieId) async => false;

  @override
  Future<bool> toggleWatchlist(Movie movie) async => true;

  @override
  Future<void> recordInHistory(Movie movie) async {}
}

void main() {
  late _PendingRepository repository;

  setUp(() {
    repository = _PendingRepository();
    final library = _EmptyUserLibraryRepository();
    di.sl.registerFactoryParam<MovieDetailsCubit, Movie, void>(
      (initialMovie, _) => MovieDetailsCubit(
        GetMovieDetailsUseCase(repository),
        GetMovieSuggestionsUseCase(repository),
        IsInWatchlistUseCase(library),
        ToggleWatchlistUseCase(library),
        RecordHistoryUseCase(library),
        initialMovie: initialMovie,
      ),
    );
  });

  tearDown(() => di.sl.reset());

  testWidgets('renders while details are still loading without throwing', (tester) async {
    // Regression test: the screen used to do `details!.screenshots[0]` on the
    // first build, which threw "Null check operator used on a null value"
    // because the API response hadn't arrived yet.
    // backgroundImage is left null so no network image is attempted in tests.
    final movie = Movie(id: 78513, title: 'A Modest Killing', year: 2026);

    await tester.pumpWidget(MaterialApp(home: MovieDetailsScreen(movie: movie)));
    await tester.pump();

    expect(tester.takeException(), isNull);
    // Header data from the tapped movie shows immediately.
    expect(find.text('A Modest Killing'), findsOneWidget);
    expect(find.text('2026'), findsOneWidget);
    // Details-dependent sections wait for the response.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Screen Shots'), findsNothing);
  });

}
