import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_movies_usecase.dart';
import 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetMoviesUseCase getMoviesUseCase;

  MoviesCubit(this.getMoviesUseCase) : super(MoviesState());

  Future<void> loadMovies() async {
    emit(state.copyWith(status: MoviesStatus.loading));
    try {
      final movies = await getMoviesUseCase(page: 1, limit: 50);
      
      final actionMovies = movies.where((m) {
        return m.genres?.any((g) => g.toLowerCase() == 'action') ?? false;
      }).toList();
      
      emit(state.copyWith(
        status: MoviesStatus.success,
        movies: movies,
        actionMovies: actionMovies,
        currentPage: 1,
        hasReachedMax: movies.isEmpty,
      ));
    } catch (e) {
      emit(state.copyWith(status: MoviesStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> loadMoreMovies() async {
    if (state.hasReachedMax || state.status == MoviesStatus.loadingMore) return;

    emit(state.copyWith(status: MoviesStatus.loadingMore));
    try {
      final nextPage = state.currentPage + 1;
      final newMovies = await getMoviesUseCase(page: nextPage);
      
      if (newMovies.isEmpty) {
        emit(state.copyWith(hasReachedMax: true, status: MoviesStatus.success));
      } else {
        final allMovies = List.of(state.movies)..addAll(newMovies);
        final actionMovies = allMovies.where((m) {
          return m.genres?.any((g) => g.toLowerCase() == 'action') ?? false;
        }).toList();
        
        emit(state.copyWith(
          status: MoviesStatus.success,
          movies: allMovies,
          actionMovies: actionMovies,
          currentPage: nextPage,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: MoviesStatus.error, errorMessage: e.toString()));
    }
  }

  void updateSelectedFeaturedIndex(int index) {
    emit(state.copyWith(selectedFeaturedIndex: index));
  }

  Future<void> refresh() async {
    await loadMovies();
  }
}
