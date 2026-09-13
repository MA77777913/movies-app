import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_details.dart';

enum MovieDetailsStatus { initial, loading, loaded, error }

class MovieDetailsState {
  final MovieDetailsStatus status;

  /// The list/carousel item that was tapped, available immediately so the
  /// screen can show a title and background image before the API responds.
  final Movie initialMovie;
  final MovieDetails? details;
  final List<Movie> suggestions;
  final String? errorMessage;

  MovieDetailsState({
    required this.initialMovie,
    this.status = MovieDetailsStatus.initial,
    this.details,
    this.suggestions = const [],
    this.errorMessage,
  });

  MovieDetailsState copyWith({
    MovieDetailsStatus? status,
    MovieDetails? details,
    List<Movie>? suggestions,
    String? errorMessage,
  }) {
    return MovieDetailsState(
      initialMovie: initialMovie,
      status: status ?? this.status,
      details: details ?? this.details,
      suggestions: suggestions ?? this.suggestions,
      errorMessage: errorMessage,
    );
  }
}
