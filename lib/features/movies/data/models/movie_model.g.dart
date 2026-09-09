// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieResponseModel _$MovieResponseModelFromJson(Map<String, dynamic> json) =>
    MovieResponseModel(
      status: json['status'] as String,
      statusMessage: json['status_message'] as String,
      data: MovieDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieResponseModelToJson(MovieResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_message': instance.statusMessage,
      'data': instance.data,
    };

MovieDataModel _$MovieDataModelFromJson(Map<String, dynamic> json) =>
    MovieDataModel(
      movieCount: (json['movie_count'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      pageNumber: (json['page_number'] as num).toInt(),
      movies: (json['movies'] as List<dynamic>?)
          ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDataModelToJson(MovieDataModel instance) =>
    <String, dynamic>{
      'movie_count': instance.movieCount,
      'limit': instance.limit,
      'page_number': instance.pageNumber,
      'movies': instance.movies,
    };

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  titleEnglish: json['title_english'] as String?,
  year: (json['year'] as num?)?.toInt(),
  rating: (json['rating'] as num?)?.toDouble(),
  runtime: (json['runtime'] as num?)?.toInt(),
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  summary: json['summary'] as String?,
  descriptionFull: json['description_full'] as String?,
  synopsis: json['synopsis'] as String?,
  ytTrailerCode: json['yt_trailer_code'] as String?,
  language: json['language'] as String?,
  mpaRating: json['mpa_rating'] as String?,
  backgroundImage: json['background_image'] as String?,
  backgroundImageOriginal: json['background_image_original'] as String?,
  smallCoverImage: json['small_cover_image'] as String?,
  mediumCoverImage: json['medium_cover_image'] as String?,
  largeCoverImage: json['large_cover_image'] as String?,
  dateUploaded: json['date_uploaded'] as String?,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'title_english': instance.titleEnglish,
      'year': instance.year,
      'rating': instance.rating,
      'runtime': instance.runtime,
      'genres': instance.genres,
      'summary': instance.summary,
      'description_full': instance.descriptionFull,
      'synopsis': instance.synopsis,
      'yt_trailer_code': instance.ytTrailerCode,
      'language': instance.language,
      'mpa_rating': instance.mpaRating,
      'background_image': instance.backgroundImage,
      'background_image_original': instance.backgroundImageOriginal,
      'small_cover_image': instance.smallCoverImage,
      'medium_cover_image': instance.mediumCoverImage,
      'large_cover_image': instance.largeCoverImage,
      'date_uploaded': instance.dateUploaded,
    };
