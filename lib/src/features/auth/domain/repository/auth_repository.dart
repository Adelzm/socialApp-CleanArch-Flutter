import '../../../../shared/domain/entities/user_entity.dart';
import '../../data/datasource/mock_auth_datasource.dart';
import '../entities/signed_in_user_entity.dart';

// The domin layer repository defines the contract (abstract class) to the data layer repository
abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<SignedInUserEntity> get signedInUser;

  Future<void> signup({required SignedInUserEntity signedInUser});
  Future<void> signin({required Username username, required Password password});
  Future<void> signout();
}
