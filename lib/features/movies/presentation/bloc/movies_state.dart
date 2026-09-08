import '../../domain/entities/movie.dart';

enum MoviesStatus { initial, loading, success, loadingMore, error }

class MoviesState {
  final MoviesStatus status;
  final List<Movie> movies;
  final List<Movie> actionMovies;
  final int currentPage;
  final bool hasReachedMax;
  final String? errorMessage;
  final int selectedFeaturedIndex;
  final String selectedGenre;

  MoviesState({
    this.status = MoviesStatus.initial,
    this.movies = const [],
    this.actionMovies = const [],
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.errorMessage,
    this.selectedFeaturedIndex = 0,
    this.selectedGenre = 'Action',
  });

  MoviesState copyWith({
    MoviesStatus? status,
    List<Movie>? movies,
    List<Movie>? actionMovies,
    int? currentPage,
    bool? hasReachedMax,
    String? errorMessage,
    int? selectedFeaturedIndex,
    String? selectedGenre,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      actionMovies: actionMovies ?? this.actionMovies,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedFeaturedIndex: selectedFeaturedIndex ?? this.selectedFeaturedIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
  }
}
