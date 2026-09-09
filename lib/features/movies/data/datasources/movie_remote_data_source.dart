import 'movie_api_service.dart';
import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<MovieResponseModel> getMovies({int page = 1, int limit = 20});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final MovieApiService apiService;

  MovieRemoteDataSourceImpl(this.apiService);

  @override
  Future<MovieResponseModel> getMovies({int page = 1, int limit = 20}) {
    return apiService.getMovies(page: page, limit: limit);
  }
}
