import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/movies/domain/entities/movie.dart';
import 'package:movies_app/features/movies/domain/entities/movie_details.dart';
import 'package:movies_app/features/movies/domain/repositories/movies_repository.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movies_app/features/movies/domain/usecases/get_movie_suggestions_usecase.dart';
import 'package:movies_app/features/movies/presentation/bloc/movie_details_cubit.dart';
import 'package:movies_app/features/movies/presentation/bloc/movie_details_state.dart';

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

  setUp(() {
    repository = _FakeMoviesRepository();
  });

  MovieDetailsCubit buildCubit() {
    return MovieDetailsCubit(
      GetMovieDetailsUseCase(repository),
      GetMovieSuggestionsUseCase(repository),
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
