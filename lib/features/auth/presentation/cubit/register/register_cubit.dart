import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;
  RegisterCubit(this._authRepository) : super(const RegisterState());

  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      final user = await _authRepository.register(
        email: email, password: password, name: name, phone: phone, avatar: avatar,
      );
      emit(state.copyWith(status: RegisterStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: RegisterStatus.failure, errorMessage: e.toString()));
    }
  }
}