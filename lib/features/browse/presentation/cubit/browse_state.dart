import '../../../movies/domain/entities/movie.dart';

enum BrowseStatus { initial, loading, success, error }

class BrowseState {
  final BrowseStatus status;
  final List<Movie> allMovies;
  final List<String> genres;
  final String selectedGenre;
  final String? errorMessage;

  const BrowseState({
    this.status = BrowseStatus.initial,
    this.allMovies = const [],
    this.genres = const [],
    this.selectedGenre = 'Action',
    this.errorMessage,
  });

  List<Movie> get filteredMovies {
    final targetGenre = selectedGenre.trim().toLowerCase();
    return allMovies.where((movie) {
      if (movie.genres == null || movie.genres!.isEmpty) return false;
      return movie.genres!.any((g) => g.trim().toLowerCase() == targetGenre);
    }).toList();
  }

  BrowseState copyWith({
    BrowseStatus? status,
    List<Movie>? allMovies,
    List<String>? genres,
    String? selectedGenre,
    String? errorMessage,
  }) {
    return BrowseState(
      status: status ?? this.status,
      allMovies: allMovies ?? this.allMovies,
      genres: genres ?? this.genres,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
