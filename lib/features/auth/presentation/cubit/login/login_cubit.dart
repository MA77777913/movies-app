import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository) : super(const LoginState());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      final user = await _authRepository.login(email: email, password: password);
      emit(state.copyWith(status: LoginStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.failure, errorMessage: e.toString()));
    }
  }
}