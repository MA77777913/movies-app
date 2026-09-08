import 'package:movies_app/features/auth/domain/entities/user_entity.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState {
  final RegisterStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const RegisterState({this.status = RegisterStatus.initial, this.user, this.errorMessage});

  RegisterState copyWith({RegisterStatus? status, UserEntity? user, String? errorMessage}) {
    return RegisterState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}