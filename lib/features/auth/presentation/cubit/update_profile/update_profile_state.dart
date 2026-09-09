import 'package:movies_app/features/auth/domain/entities/user_entity.dart';

enum UpdateProfileStatus { initial, loading, loaded, submitting, success, failure }

class UpdateProfileState {
  final UpdateProfileStatus status;
  final UserEntity? user;
  final String? errorMessage;

  const UpdateProfileState({this.status = UpdateProfileStatus.initial, this.user, this.errorMessage});

  UpdateProfileState copyWith({UpdateProfileStatus? status, UserEntity? user, String? errorMessage}) {
    return UpdateProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}