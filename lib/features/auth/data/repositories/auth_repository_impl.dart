import 'package:movies_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:movies_app/features/auth/domain/entities/user_entity.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl({AuthRemoteDataSource? remoteDataSource})
      : _remoteDataSource = remoteDataSource ?? AuthRemoteDataSource();

  @override
  Future<UserEntity> login({required String email, required String password}) {
    return _remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) {
    return _remoteDataSource.register(email: email, password: password, name: name, phone: phone, avatar: avatar);
  }

  @override
  Future<UserEntity> getCurrentUserProfile() {
    return _remoteDataSource.getCurrentUserProfile();
  }

  @override
  Future<void> resetPassword({required String email}) {
    return _remoteDataSource.resetPassword(email: email);
  }

  @override
  Future<void> signOut() {
    return _remoteDataSource.signOut();
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) {
    return _remoteDataSource.updateProfile(name: name, phone: phone, avatar: avatar);
  }
}