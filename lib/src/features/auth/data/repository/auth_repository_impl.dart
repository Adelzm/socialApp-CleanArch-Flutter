import 'package:social_media_clean_archi/src/features/auth/domain/repository/auth_repository.dart';

import '../../../../shared/domain/entities/user_entity.dart';
import '../../data/datasource/mock_auth_datasource.dart';
import '../../domain/entities/signedin_user_entity.dart';

// The role of the repo is to decide which data source to use
// since we have only one data source, we have a one to one match
// between the data source and the repo.
class AuthRepositoryImpl extends AuthRepository {
  final MockAuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Stream<AuthStatus> get status => authDatasource.status;


  @override
  Future<SignedInUserEntity> get signedInUser => authDatasource.signInUser;

  @override
  Future<void> signin({
    required Username username,
    required Password password,
  }) {
    return authDatasource.signin(username: username, password: password);
  }

  @override
  Future<void> signout() {
    return authDatasource.signout();
  }

  @override
  Future<void> signup({required SignedInUserEntity signedInUser}) {
    return authDatasource.signup(signedInUser: signedInUser);
  }
}
