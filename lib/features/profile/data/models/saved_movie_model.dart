import '../../../movies/domain/entities/movie.dart';

/// A snapshot of the fields the profile grid needs, stored alongside the
/// saved movie so the lists render without re-querying the movies API.
class SavedMovieModel {
  final int id;
  final String title;
  final double? rating;
  final int? year;
  final String? mediumCoverImage;
  final String? largeCoverImage;
  final String? backgroundImage;
  final DateTime? savedAt;

  SavedMovieModel({
    required this.id,
    required this.title,
    this.rating,
    this.year,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.backgroundImage,
    this.savedAt,
  });

  factory SavedMovieModel.fromMovie(Movie movie) {
    return SavedMovieModel(
      id: movie.id,
      title: movie.title,
      rating: movie.rating,
      year: movie.year,
      mediumCoverImage: movie.mediumCoverImage,
      largeCoverImage: movie.largeCoverImage,
      backgroundImage: movie.backgroundImage,
    );
  }

  factory SavedMovieModel.fromMap(Map<String, dynamic> map) {
    final savedAt = map['savedAt'];
    return SavedMovieModel(
      id: (map['id'] as num).toInt(),
      title: map['title'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble(),
      year: (map['year'] as num?)?.toInt(),
      mediumCoverImage: map['mediumCoverImage'] as String?,
      largeCoverImage: map['largeCoverImage'] as String?,
      backgroundImage: map['backgroundImage'] as String?,
      // Firestore hands back a Timestamp, which exposes toDate().
      savedAt: savedAt == null ? null : (savedAt as dynamic).toDate() as DateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
      'year': year,
      'mediumCoverImage': mediumCoverImage,
      'largeCoverImage': largeCoverImage,
      'backgroundImage': backgroundImage,
    };
  }

  Movie toEntity() {
    return Movie(
      id: id,
      title: title,
      rating: rating,
      year: year,
      mediumCoverImage: mediumCoverImage,
      largeCoverImage: largeCoverImage,
      backgroundImage: backgroundImage,
    );
  }
}
