import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieResponseModel {
  final String status;
  @JsonKey(name: 'status_message')
  final String statusMessage;
  final MovieDataModel data;

  MovieResponseModel({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MovieResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseModelFromJson(json);
}

@JsonSerializable()
class MovieDataModel {
  @JsonKey(name: 'movie_count')
  final int movieCount;
  // list_movies.json always returns these; movie_suggestions.json doesn't,
  // so they have to stay nullable since this model is shared by both.
  final int? limit;
  @JsonKey(name: 'page_number')
  final int? pageNumber;
  final List<MovieModel>? movies;

  MovieDataModel({
    required this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,
  });

  factory MovieDataModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDataModelFromJson(json);
}

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;
  @JsonKey(name: 'title_english')
  final String? titleEnglish;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String? summary;
  @JsonKey(name: 'description_full')
  final String? descriptionFull;
  final String? synopsis;
  @JsonKey(name: 'yt_trailer_code')
  final String? ytTrailerCode;
  final String? language;
  @JsonKey(name: 'mpa_rating')
  final String? mpaRating;
  @JsonKey(name: 'background_image')
  final String? backgroundImage;
  @JsonKey(name: 'background_image_original')
  final String? backgroundImageOriginal;
  @JsonKey(name: 'small_cover_image')
  final String? smallCoverImage;
  @JsonKey(name: 'medium_cover_image')
  final String? mediumCoverImage;
  @JsonKey(name: 'large_cover_image')
  final String? largeCoverImage;
  @JsonKey(name: 'date_uploaded')
  final String? dateUploaded;

  MovieModel({
    required this.id,
    required this.title,
    this.titleEnglish,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.dateUploaded,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      titleEnglish: titleEnglish,
      year: year,
      rating: rating?.toDouble(),
      runtime: runtime,
      genres: genres,
      summary: summary,
      descriptionFull: descriptionFull,
      synopsis: synopsis,
      ytTrailerCode: ytTrailerCode,
      language: language,
      mpaRating: mpaRating,
      backgroundImage: backgroundImage,
      backgroundImageOriginal: backgroundImageOriginal,
      smallCoverImage: smallCoverImage,
      mediumCoverImage: mediumCoverImage,
      largeCoverImage: largeCoverImage,
      dateUploaded: dateUploaded,
    );
  }
}
