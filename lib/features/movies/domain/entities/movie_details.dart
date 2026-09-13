class MovieDetails {
  final int id;
  final String title;
  final String? titleEnglish;
  final int? year;
  final double? rating;
  final int? runtime;
  final List<String>? genres;
  final String? summary;
  final String? descriptionFull;
  final int likeCount;
  final String? ytTrailerCode;
  final String? language;
  final String? mpaRating;
  final String? backgroundImage;
  final String? backgroundImageOriginal;
  final String? mediumCoverImage;
  final String? largeCoverImage;

  /// Screenshot URLs for the movie, largest resolution available first.
  final List<String> screenshots;

  MovieDetails({
    required this.id,
    required this.title,
    this.titleEnglish,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.likeCount = 0,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.screenshots = const [],
  });
}
