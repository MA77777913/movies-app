import 'package:movies_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});

  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  });

  Future<void> resetPassword({required String email});

  Future<UserEntity> getCurrentUserProfile();

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  });
}