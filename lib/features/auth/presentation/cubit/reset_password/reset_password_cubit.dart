import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;
  ResetPasswordCubit(this._authRepository) : super(const ResetPasswordState());

  Future<void> resetPassword({required String email}) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));
    try {
      await _authRepository.resetPassword(email: email);
      emit(state.copyWith(status: ResetPasswordStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ResetPasswordStatus.failure, errorMessage: e.toString()));
    }
  }
}