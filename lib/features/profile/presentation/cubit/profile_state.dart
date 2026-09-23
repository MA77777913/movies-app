import '../../../auth/domain/entities/user_entity.dart';
import '../../../movies/domain/entities/movie.dart';

enum ProfileStatus { initial, loading, loaded, error }

enum SignOutStatus { idle, inProgress, success, failure }

class ProfileState {
  final ProfileStatus status;
  final UserEntity? user;
  final List<Movie> watchlist;
  final List<Movie> history;
  final SignOutStatus signOutStatus;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.user,
    this.watchlist = const [],
    this.history = const [],
    this.signOutStatus = SignOutStatus.idle,
    this.errorMessage,
  });

  int get watchlistCount => watchlist.length;

  int get historyCount => history.length;

  ProfileState copyWith({
    ProfileStatus? status,
    UserEntity? user,
    List<Movie>? watchlist,
    List<Movie>? history,
    SignOutStatus? signOutStatus,
    String? errorMessage,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      watchlist: watchlist ?? this.watchlist,
      history: history ?? this.history,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      errorMessage: errorMessage,
    );
  }
}
