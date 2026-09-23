import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/auth/domain/entities/user_entity.dart';
import 'package:movies_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:movies_app/features/movies/domain/entities/movie.dart';
import 'package:movies_app/features/profile/domain/repositories/user_library_repository.dart';
import 'package:movies_app/features/profile/domain/usecases/get_history_usecase.dart';
import 'package:movies_app/features/profile/domain/usecases/get_watchlist_usecase.dart';
import 'package:movies_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:movies_app/features/profile/presentation/cubit/profile_state.dart';

class _FakeAuthRepository implements AuthRepository {
  UserEntity? profileToReturn;
  Object? profileError;
  Object? signOutError;
  bool signedOut = false;

  @override
  Future<UserEntity> getCurrentUserProfile() async {
    if (profileError != null) throw profileError!;
    return profileToReturn!;
  }

  @override
  Future<void> signOut() async {
    if (signOutError != null) throw signOutError!;
    signedOut = true;
  }

  @override
  Future<UserEntity> login({required String email, required String password}) async =>
      throw UnimplementedError();

  @override
  Future<UserEntity> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async =>
      throw UnimplementedError();

  @override
  Future<void> resetPassword({required String email}) async =>
      throw UnimplementedError();

  @override
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async =>
      throw UnimplementedError();
}

class _FakeUserLibraryRepository implements UserLibraryRepository {
  List<Movie> watchlist = const [];
  List<Movie> history = const [];

  @override
  Future<List<Movie>> getWatchlist() async => watchlist;

  @override
  Future<List<Movie>> getHistory() async => history;

  @override
  Future<bool> isInWatchlist(int movieId) async => false;

  @override
  Future<bool> toggleWatchlist(Movie movie) async => true;

  @override
  Future<void> recordInHistory(Movie movie) async {}
}

UserEntity _user() => const UserEntity(
      uid: 'uid-1',
      email: 'someone@example.com',
      name: 'Test User',
      phone: '1234567890',
      avatar: 'assets/image/avatar3.png',
    );

void main() {
  late _FakeAuthRepository auth;
  late _FakeUserLibraryRepository library;

  ProfileCubit buildCubit() => ProfileCubit(
        auth,
        GetWatchlistUseCase(library),
        GetHistoryUseCase(library),
      );

  setUp(() {
    auth = _FakeAuthRepository();
    library = _FakeUserLibraryRepository();
  });

  test('loadProfile fills the user and both lists', () async {
    auth.profileToReturn = _user();
    library.watchlist = [Movie(id: 1, title: 'One'), Movie(id: 2, title: 'Two')];
    library.history = [Movie(id: 3, title: 'Three')];

    final cubit = buildCubit();
    await cubit.loadProfile();

    expect(cubit.state.status, ProfileStatus.loaded);
    expect(cubit.state.user?.name, 'Test User');
    expect(cubit.state.watchlist, hasLength(2));
    expect(cubit.state.history, hasLength(1));
  });

  test('the counters shown above the labels come from the list lengths', () async {
    auth.profileToReturn = _user();
    library.watchlist = List.generate(12, (i) => Movie(id: i, title: 'Movie $i'));
    library.history = List.generate(10, (i) => Movie(id: 100 + i, title: 'Seen $i'));

    final cubit = buildCubit();
    await cubit.loadProfile();

    expect(cubit.state.watchlistCount, 12);
    expect(cubit.state.historyCount, 10);
  });

  test('loadProfile reports an error when the profile cannot be read', () async {
    auth.profileError = Exception('no user');

    final cubit = buildCubit();
    await cubit.loadProfile();

    expect(cubit.state.status, ProfileStatus.error);
    expect(cubit.state.errorMessage, contains('no user'));
  });

  test('signOut succeeds so the screen can return to login', () async {
    final cubit = buildCubit();
    await cubit.signOut();

    expect(auth.signedOut, isTrue);
    expect(cubit.state.signOutStatus, SignOutStatus.success);
  });

  test('signOut failure is surfaced instead of stranding the user', () async {
    auth.signOutError = Exception('network');

    final cubit = buildCubit();
    await cubit.signOut();

    expect(cubit.state.signOutStatus, SignOutStatus.failure);
    expect(cubit.state.errorMessage, contains('network'));
  });
}
