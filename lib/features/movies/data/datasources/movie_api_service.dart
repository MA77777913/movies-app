import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/movie_model.dart';
import '../models/movie_details_model.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: 'https://movies-api.accel.li/api/v2/')
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String? baseUrl}) = _MovieApiService;

  @GET('/list_movies.json')
  Future<MovieResponseModel> getMovies({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });

  @GET('/movie_details.json')
  Future<MovieDetailsResponseModel> getMovieDetails({
    @Query('movie_id') required int movieId,
    @Query('with_images') bool withImages = true,
    @Query('with_cast') bool withCast = true,
  });

  @GET('/movie_suggestions.json')
  Future<MovieResponseModel> getMovieSuggestions({
    @Query('movie_id') required int movieId,
  });
}
