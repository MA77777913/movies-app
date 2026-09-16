import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/cast_member.dart';
import '../../domain/entities/movie_details.dart';

part 'movie_details_model.g.dart';

@JsonSerializable()
class MovieDetailsResponseModel {
  final String status;
  @JsonKey(name: 'status_message')
  final String statusMessage;
  final MovieDetailsDataModel data;

  MovieDetailsResponseModel({
    required this.status,
    required this.statusMessage,
    required this.data,
  });

  factory MovieDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseModelFromJson(json);
}

@JsonSerializable()
class MovieDetailsDataModel {
  final MovieDetailsModel movie;

  MovieDetailsDataModel({required this.movie});

  factory MovieDetailsDataModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsDataModelFromJson(json);
}

@JsonSerializable()
class CastMemberModel {
  final String name;
  @JsonKey(name: 'character_name')
  final String? characterName;
  @JsonKey(name: 'url_small_image')
  final String? urlSmallImage;
  @JsonKey(name: 'imdb_code')
  final String? imdbCode;

  CastMemberModel({
    required this.name,
    this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  factory CastMemberModel.fromJson(Map<String, dynamic> json) =>
      _$CastMemberModelFromJson(json);

  CastMember toEntity() {
    return CastMember(
      name: name,
      characterName: characterName,
      urlSmallImage: urlSmallImage,
      imdbCode: imdbCode,
    );
  }
}

@JsonSerializable()
class MovieDetailsModel {
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
  @JsonKey(name: 'like_count')
  final int? likeCount;
  @JsonKey(name: 'yt_trailer_code')
  final String? ytTrailerCode;
  final String? language;
  @JsonKey(name: 'mpa_rating')
  final String? mpaRating;
  @JsonKey(name: 'background_image')
  final String? backgroundImage;
  @JsonKey(name: 'background_image_original')
  final String? backgroundImageOriginal;
  @JsonKey(name: 'medium_cover_image')
  final String? mediumCoverImage;
  @JsonKey(name: 'large_cover_image')
  final String? largeCoverImage;
  @JsonKey(name: 'medium_screenshot_image1')
  final String? mediumScreenshotImage1;
  @JsonKey(name: 'medium_screenshot_image2')
  final String? mediumScreenshotImage2;
  @JsonKey(name: 'medium_screenshot_image3')
  final String? mediumScreenshotImage3;
  @JsonKey(name: 'large_screenshot_image1')
  final String? largeScreenshotImage1;
  @JsonKey(name: 'large_screenshot_image2')
  final String? largeScreenshotImage2;
  @JsonKey(name: 'large_screenshot_image3')
  final String? largeScreenshotImage3;
  final List<CastMemberModel>? cast;

  MovieDetailsModel({
    required this.id,
    required this.title,
    this.titleEnglish,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.likeCount,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.mediumScreenshotImage1,
    this.mediumScreenshotImage2,
    this.mediumScreenshotImage3,
    this.largeScreenshotImage1,
    this.largeScreenshotImage2,
    this.largeScreenshotImage3,
    this.cast,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);

  MovieDetails toEntity() {
    final screenshots = <String>[
      ?largeScreenshotImage1,
      ?largeScreenshotImage2,
      ?largeScreenshotImage3,
    ];
    if (screenshots.isEmpty) {
      screenshots.addAll([
        ?mediumScreenshotImage1,
        ?mediumScreenshotImage2,
        ?mediumScreenshotImage3,
      ]);
    }

    return MovieDetails(
      id: id,
      title: title,
      titleEnglish: titleEnglish,
      year: year,
      rating: rating?.toDouble(),
      runtime: runtime,
      genres: genres,
      summary: summary,
      descriptionFull: descriptionFull,
      likeCount: likeCount ?? 0,
      ytTrailerCode: ytTrailerCode,
      language: language,
      mpaRating: mpaRating,
      backgroundImage: backgroundImage,
      backgroundImageOriginal: backgroundImageOriginal,
      mediumCoverImage: mediumCoverImage,
      largeCoverImage: largeCoverImage,
      screenshots: screenshots,
      cast: cast?.map((c) => c.toEntity()).toList() ?? const [],
    );
  }
}
