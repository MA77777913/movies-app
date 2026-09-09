import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';
import 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final AuthRepository _authRepository;
  UpdateProfileCubit(this._authRepository) : super(const UpdateProfileState());

  Future<void> loadProfile() async {
    emit(state.copyWith(status: UpdateProfileStatus.loading));
    try {
      final user = await _authRepository.getCurrentUserProfile();
      emit(state.copyWith(status: UpdateProfileStatus.loaded, user: user));
    } catch (e) {
      emit(state.copyWith(status: UpdateProfileStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(state.copyWith(status: UpdateProfileStatus.submitting));
    try {
      await _authRepository.updateProfile(name: name, phone: phone, avatar: avatar);
      emit(state.copyWith(status: UpdateProfileStatus.success));
    } catch (e) {
      emit(state.copyWith(status: UpdateProfileStatus.failure, errorMessage: e.toString()));
    }
  }
}