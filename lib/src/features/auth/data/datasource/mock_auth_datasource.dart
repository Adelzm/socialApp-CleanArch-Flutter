import 'dart:async';

import 'package:social_media_clean_archi/src/features/auth/domain/entities/signedin_user_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

enum AuthStatus { unknow, authenticated, unauthenticated }

abstract class MockAuthDatasource {
  Stream<AuthStatus> get status;
  Future<SignedInUserEntity> get signInUser;

  Future<void> signup({required SignedInUserEntity signedInUser});
  Future<void> signin({required Username username, required Password password});
  Future<void> signout();
}

// Create an implementation of the MockAuthDatasource
class MockAuthDatasourceImpl extends MockAuthDatasource {
  // Becase we want either to pass the cache as input to the Mock.. or
  // initialize it if not.
  MockAuthDatasourceImpl({CacheClient? cache})
      : _cache = cache ?? CacheClient();

  final CacheClient _cache;
  final _controller = StreamController<AuthStatus>();

  static const userCacheKey = '__user_cache_key';

  @override
  Stream<AuthStatus> get status async* {
    Future.delayed(const Duration(seconds: 1));
    yield AuthStatus.unauthenticated; // Yield the initial state of our stream
    yield* _controller
        .stream; // Yield a steam to listen to in other parts of the app
  }

  @override
  Future<SignedInUserEntity> get signInUser {
    return Future.delayed(const Duration(microseconds: 300), () {
      return _cache.read(key: userCacheKey) ?? SignedInUserEntity.empty;
    });
  }

  @override
  Future<void> signup({required SignedInUserEntity signedInUser}) {
    return Future.delayed(const Duration(microseconds: 300), () {
      _allUsers.add(signedInUser);

      _updateSignedInUser(
          id: signedInUser.id,
          username: signedInUser.username,
          email: signedInUser.email);

      _controller.add(AuthStatus.unauthenticated);
    });
  }

  @override
  Future<void> signin(
      {required Username username, required Password password}) {
    return Future.delayed(const Duration(microseconds: 300), () {
      for (final user in _allUsers) {
        if (user.username.value == username.value) {
          _updateSignedInUser(id: user.id, username: user.username);
          _controller.add(AuthStatus.authenticated);
          return;
        }
      }
      throw  LoginWithUsernameAndPasswordFailure.fromCode('user-not-found');
    });
  }

  @override
  Future<void> signout() {
    return Future.delayed(const Duration(microseconds: 300), () {
      _cache.write(key: userCacheKey, value: SignedInUserEntity.empty);
      return _controller.add(AuthStatus.unauthenticated);
    });
  }

  void _updateSignedInUser({String? id, Username? username, Email? email}) {
    SignedInUserEntity signedInUser =
        _cache.read(key: userCacheKey) ?? SignedInUserEntity.empty;

    _cache.write(
      key: userCacheKey,
      value: signedInUser.copyWith(id: id, username: username, email: email),
    );
  }

  final List<UserEntity> _allUsers = [
    const UserEntity(
      id: 'user_1',
      username: Username.dirty('Massimo'),
      imagePath: 'assets/images/image_1.jpg',
    ),
    const UserEntity(
      id: 'user_2',
      username: Username.dirty('Sarah'),
      imagePath: 'assets/images/image_2.jpg',
    ),
    const UserEntity(
      id: 'user_3',
      username: Username.dirty('John'),
      imagePath: 'assets/images/image_3.jpg',
    ),
  ];
}

class CacheClient {
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}

class LoginWithUsernameAndPasswordFailure implements Exception {
  final String message;

  const LoginWithUsernameAndPasswordFailure(this.message);

  factory LoginWithUsernameAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-username':
        return const LoginWithUsernameAndPasswordFailure(
            'Username is not valid');

      case 'user-not-found':
        return const LoginWithUsernameAndPasswordFailure(
            'Username is not found, please create an account');

      default:
        return const LoginWithUsernameAndPasswordFailure(
            'An unknow exception occured');
    }
  }
}
