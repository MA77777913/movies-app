import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_history_usecase.dart';
import '../../domain/usecases/get_watchlist_usecase.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepository authRepository;
  final GetWatchlistUseCase getWatchlistUseCase;
  final GetHistoryUseCase getHistoryUseCase;

  ProfileCubit(
    this.authRepository,
    this.getWatchlistUseCase,
    this.getHistoryUseCase,
  ) : super(const ProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: ProfileStatus.loading));
    try {
      final userFuture = authRepository.getCurrentUserProfile();
      final watchlistFuture = getWatchlistUseCase();
      final historyFuture = getHistoryUseCase();
      final user = await userFuture;
      final watchlist = await watchlistFuture;
      final history = await historyFuture;
      emit(state.copyWith(
        status: ProfileStatus.loaded,
        user: user,
        watchlist: watchlist,
        history: history,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(signOutStatus: SignOutStatus.inProgress));
    try {
      await authRepository.signOut();
      emit(state.copyWith(signOutStatus: SignOutStatus.success));
    } catch (e) {
      emit(state.copyWith(
        signOutStatus: SignOutStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
