import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../domain/usecases/watch_history_usecase.dart';
import '../../domain/usecases/watch_watchlist_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository authRepository;
  final WatchWatchlistUseCase watchWatchlistUseCase;
  final WatchHistoryUseCase watchHistoryUseCase;

  StreamSubscription<List<Movie>>? _watchlistSubscription;
  StreamSubscription<List<Movie>>? _historySubscription;

  ProfileCubit(
    this.authRepository,
    this.watchWatchlistUseCase,
    this.watchHistoryUseCase,
  ) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final user = await authRepository.getCurrentUserProfile();
      emit(state.copyWith(status: ProfileStatus.loaded, user: user));
      _subscribeToLibrary();
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// The counters track the database: opening a movie elsewhere in the app
  /// writes to Firestore and the new value arrives here on its own.
  void _subscribeToLibrary() {
    _watchlistSubscription?.cancel();
    _historySubscription?.cancel();

    _watchlistSubscription = watchWatchlistUseCase().listen(
      (watchlist) => emit(state.copyWith(watchlist: watchlist)),
      onError: (Object e) => emit(state.copyWith(errorMessage: e.toString())),
    );
    _historySubscription = watchHistoryUseCase().listen(
      (history) => emit(state.copyWith(history: history)),
      onError: (Object e) => emit(state.copyWith(errorMessage: e.toString())),
    );
  }

  Future<void> signOut() async {
    emit(state.copyWith(signOutStatus: SignOutStatus.inProgress));
    try {
      await _watchlistSubscription?.cancel();
      await _historySubscription?.cancel();
      _watchlistSubscription = null;
      _historySubscription = null;
      await authRepository.signOut();
      emit(state.copyWith(signOutStatus: SignOutStatus.success));
    } catch (e) {
      emit(state.copyWith(
        signOutStatus: SignOutStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  Future<void> close() {
    _watchlistSubscription?.cancel();
    _historySubscription?.cancel();
    return super.close();
  }
}
