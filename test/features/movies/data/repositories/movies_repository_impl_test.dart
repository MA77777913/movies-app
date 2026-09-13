import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies_app/features/movies/data/models/movie_details_model.dart';
import 'package:movies_app/features/movies/data/models/movie_model.dart';
import 'package:movies_app/features/movies/data/repositories/movies_repository_impl.dart';

class _FakeMovieRemoteDataSource implements MovieRemoteDataSource {
  MovieResponseModel? moviesResponse;
  MovieDetailsResponseModel? detailsResponse;
  MovieResponseModel? suggestionsResponse;
  int? lastRequestedMovieId;

  @override
  Future<MovieResponseModel> getMovies({int page = 1, int limit = 20}) async {
    return moviesResponse!;
  }

  @override
  Future<MovieDetailsResponseModel> getMovieDetails({required int movieId}) async {
    lastRequestedMovieId = movieId;
    return detailsResponse!;
  }

  @override
  Future<MovieResponseModel> getMovieSuggestions({required int movieId}) async {
    lastRequestedMovieId = movieId;
    return suggestionsResponse!;
  }
}

MovieModel _movieModel(int id, String title) => MovieModel(id: id, title: title);

void main() {
  late _FakeMovieRemoteDataSource dataSource;
  late MoviesRepositoryImpl repository;

  setUp(() {
    dataSource = _FakeMovieRemoteDataSource();
    repository = MoviesRepositoryImpl(dataSource);
  });

  test('getMovieDetails forwards the id and maps the response to an entity', () async {
    dataSource.detailsResponse = MovieDetailsResponseModel(
      status: 'ok',
      statusMessage: 'ok',
      data: MovieDetailsDataModel(
        movie: MovieDetailsModel(id: 42, title: 'Test Movie', likeCount: 7, runtime: 100),
      ),
    );

    final details = await repository.getMovieDetails(movieId: 42);

    expect(dataSource.lastRequestedMovieId, 42);
    expect(details.id, 42);
    expect(details.title, 'Test Movie');
    expect(details.likeCount, 7);
    expect(details.runtime, 100);
  });

  test('getMovieSuggestions maps the movie list to entities', () async {
    dataSource.suggestionsResponse = MovieResponseModel(
      status: 'ok',
      statusMessage: 'ok',
      data: MovieDataModel(
        movieCount: 0,
        movies: [_movieModel(1, 'Suggestion One'), _movieModel(2, 'Suggestion Two')],
      ),
    );

    final suggestions = await repository.getMovieSuggestions(movieId: 42);

    expect(dataSource.lastRequestedMovieId, 42);
    expect(suggestions.map((m) => m.title), ['Suggestion One', 'Suggestion Two']);
  });

  test('getMovieSuggestions returns an empty list when movies is null', () async {
    dataSource.suggestionsResponse = MovieResponseModel(
      status: 'ok',
      statusMessage: 'ok',
      data: MovieDataModel(movieCount: 0),
    );

    final suggestions = await repository.getMovieSuggestions(movieId: 42);

    expect(suggestions, isEmpty);
  });
}
