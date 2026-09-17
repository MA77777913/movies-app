import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_movie_details_usecase.dart';
import '../../domain/usecases/get_movie_suggestions_usecase.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetMovieSuggestionsUseCase getMovieSuggestionsUseCase;

  MovieDetailsCubit(
    this.getMovieDetailsUseCase,
    this.getMovieSuggestionsUseCase, {
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
  }
}
