// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsResponseModel _$MovieDetailsResponseModelFromJson(
  Map<String, dynamic> json,
) => MovieDetailsResponseModel(
  status: json['status'] as String,
  statusMessage: json['status_message'] as String,
  data: MovieDetailsDataModel.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MovieDetailsResponseModelToJson(
  MovieDetailsResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'status_message': instance.statusMessage,
  'data': instance.data,
};

MovieDetailsDataModel _$MovieDetailsDataModelFromJson(
  Map<String, dynamic> json,
) => MovieDetailsDataModel(
  movie: MovieDetailsModel.fromJson(json['movie'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MovieDetailsDataModelToJson(
  MovieDetailsDataModel instance,
) => <String, dynamic>{'movie': instance.movie};

CastMemberModel _$CastMemberModelFromJson(Map<String, dynamic> json) =>
    CastMemberModel(
      name: json['name'] as String,
      characterName: json['character_name'] as String?,
      urlSmallImage: json['url_small_image'] as String?,
      imdbCode: json['imdb_code'] as String?,
    );

Map<String, dynamic> _$CastMemberModelToJson(CastMemberModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'character_name': instance.characterName,
      'url_small_image': instance.urlSmallImage,
      'imdb_code': instance.imdbCode,
    };

MovieDetailsModel _$MovieDetailsModelFromJson(Map<String, dynamic> json) =>
    MovieDetailsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      titleEnglish: json['title_english'] as String?,
      year: (json['year'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      runtime: (json['runtime'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      summary: json['summary'] as String?,
      descriptionFull: json['description_full'] as String?,
      likeCount: (json['like_count'] as num?)?.toInt(),
      ytTrailerCode: json['yt_trailer_code'] as String?,
      language: json['language'] as String?,
      mpaRating: json['mpa_rating'] as String?,
      backgroundImage: json['background_image'] as String?,
      backgroundImageOriginal: json['background_image_original'] as String?,
      mediumCoverImage: json['medium_cover_image'] as String?,
      largeCoverImage: json['large_cover_image'] as String?,
      mediumScreenshotImage1: json['medium_screenshot_image1'] as String?,
      mediumScreenshotImage2: json['medium_screenshot_image2'] as String?,
      mediumScreenshotImage3: json['medium_screenshot_image3'] as String?,
      largeScreenshotImage1: json['large_screenshot_image1'] as String?,
      largeScreenshotImage2: json['large_screenshot_image2'] as String?,
      largeScreenshotImage3: json['large_screenshot_image3'] as String?,
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => CastMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsModelToJson(MovieDetailsModel instance) =>
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
      'like_count': instance.likeCount,
      'yt_trailer_code': instance.ytTrailerCode,
      'language': instance.language,
      'mpa_rating': instance.mpaRating,
      'background_image': instance.backgroundImage,
      'background_image_original': instance.backgroundImageOriginal,
      'medium_cover_image': instance.mediumCoverImage,
      'large_cover_image': instance.largeCoverImage,
      'medium_screenshot_image1': instance.mediumScreenshotImage1,
      'medium_screenshot_image2': instance.mediumScreenshotImage2,
      'medium_screenshot_image3': instance.mediumScreenshotImage3,
      'large_screenshot_image1': instance.largeScreenshotImage1,
      'large_screenshot_image2': instance.largeScreenshotImage2,
      'large_screenshot_image3': instance.largeScreenshotImage3,
      'cast': instance.cast,
    };
