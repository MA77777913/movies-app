import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../movies/domain/usecases/get_movies_usecase.dart';
import 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final GetMoviesUseCase getMoviesUseCase;

  BrowseCubit(this.getMoviesUseCase) : super(const BrowseState());

  Future<void> loadMovies() async {
    emit(state.copyWith(status: BrowseStatus.loading));
    try {
      final movies = await getMoviesUseCase(page: 1, limit: 50);

      final genresSet = <String>{};
      for (final movie in movies) {
        for (final genre in movie.genres ?? <String>[]) {
          if (genre.trim().isNotEmpty) {
            genresSet.add(genre.trim());
          }
        }
      }

      final genresList = genresSet.toList();

      if (genresList.any((genre) => genre.toLowerCase() == 'action')) {
        genresList.removeWhere((genre) => genre.toLowerCase() == 'action');
        genresList.insert(0, 'Action');
      }

      emit(state.copyWith(
        status: BrowseStatus.success,
        allMovies: movies,
        genres: genresList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: BrowseStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void selectGenre(String genre) {
    emit(state.copyWith(selectedGenre: genre));
  }
}
