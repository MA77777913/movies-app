import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../profile/domain/usecases/is_in_watchlist_usecase.dart';
import '../../../profile/domain/usecases/record_history_usecase.dart';
import '../../../profile/domain/usecases/toggle_watchlist_usecase.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../../domain/usecases/get_movie_suggestions_usecase.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetMovieSuggestionsUseCase getMovieSuggestionsUseCase;
  final IsInWatchlistUseCase isInWatchlistUseCase;
  final ToggleWatchlistUseCase toggleWatchlistUseCase;
  final RecordHistoryUseCase recordHistoryUseCase;

  MovieDetailsCubit(
    this.getMovieDetailsUseCase,
    this.getMovieSuggestionsUseCase,
    this.isInWatchlistUseCase,
    this.toggleWatchlistUseCase,
    this.recordHistoryUseCase, {
    required Movie initialMovie,
  }) : super(MovieDetailsState(initialMovie: initialMovie));

  Future<void> loadDetails() async {
    emit(state.copyWith(status: MovieDetailsStatus.loading));
    try {
      final movieId = state.initialMovie.id;
      final detailsFuture = getMovieDetailsUseCase(movieId: movieId);
      final suggestionsFuture = getMovieSuggestionsUseCase(movieId: movieId);
      final details = await detailsFuture;
      final suggestions = await suggestionsFuture;
      emit(state.copyWith(
        status: MovieDetailsStatus.loaded,
        details: details,
        suggestions: suggestions,
      ));
    } catch (e) {
      emit(state.copyWith(status: MovieDetailsStatus.error, errorMessage: e.toString()));
    }

    // The library is a separate concern from the movie data: a signed-out
    // user or a Firestore hiccup should not turn the screen into an error.
    await _syncWatchlistFlag();
    await _recordVisit();
  }

  Future<void> toggleWatchlist() async {
    final movie = state.initialMovie;
    // Flip straight away so the bookmark responds to the tap.
    final optimistic = !state.isInWatchlist;
    _emitWatchlistFlag(optimistic);
    try {
      final saved = await toggleWatchlistUseCase(movie);
      _emitWatchlistFlag(saved);
    } catch (_) {
      _emitWatchlistFlag(!optimistic);
    }
  }

  Future<void> _syncWatchlistFlag() async {
    try {
      final saved = await isInWatchlistUseCase(state.initialMovie.id);
      _emitWatchlistFlag(saved);
    } catch (e) {
      // Leave the flag as it is, but say why: a denied read here usually
      // means the Firestore rules have not been published.
      debugPrint('Could not read watch list state: $e');
    }
  }

  /// copyWith drops errorMessage unless it is passed again, so carry it over:
  /// a watch list update must not erase a failure from loading the movie.
  void _emitWatchlistFlag(bool isInWatchlist) {
    emit(state.copyWith(
      isInWatchlist: isInWatchlist,
      errorMessage: state.errorMessage,
    ));
  }

  Future<void> _recordVisit() async {
    try {
      await recordHistoryUseCase(state.initialMovie);
    } catch (e) {
      // History is best effort, but a silent failure here is what makes the
      // profile counter look stuck, so leave a trace.
      debugPrint('Could not record this movie in history: $e');
    }
  }
}
