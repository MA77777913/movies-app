import 'movie_api_service.dart';
import '../models/movie_model.dart';
import '../models/movie_details_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponseModel> getMovies({int page = 1, int limit = 20});

  Future<MovieDetailsResponseModel> getMovieDetails({required int movieId});

  Future<MovieResponseModel> getMovieSuggestions({required int movieId});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final MovieApiService apiService;

  MovieRemoteDataSourceImpl(this.apiService);

  @override
  Future<MovieResponseModel> getMovies({int page = 1, int limit = 20}) {
    return apiService.getMovies(page: page, limit: limit);
  }

  @override
  Future<MovieDetailsResponseModel> getMovieDetails({required int movieId}) {
    return apiService.getMovieDetails(movieId: movieId);
  }

  @override
  Future<MovieResponseModel> getMovieSuggestions({required int movieId}) {
    return apiService.getMovieSuggestions(movieId: movieId);
  }
}
