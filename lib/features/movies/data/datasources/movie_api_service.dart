import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/movie_model.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: 'https://movies-api.accel.li/api/v2/')
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String? baseUrl}) = _MovieApiService;

  @GET('/list_movies.json')
  Future<MovieResponseModel> getMovies({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });
}
