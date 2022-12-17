import '../../../../shared/domain/entities/user_entity.dart';
import '../../data/datasource/mock_auth_datasource.dart';
import '../entities/signedin_user_entity.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<SignedInUserEntity> get signedInUser;

  Future<void> signup({required SignedInUserEntity signedInUser});
  Future<void> signin({required Username username, required Password password});
  Future<void> signout();
}
