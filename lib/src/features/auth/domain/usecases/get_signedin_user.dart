import 'package:social_media_clean_archi/src/features/auth/domain/entities/signed_in_user_entity.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class GetSignedInUser implements UseCase<SignedInUserEntity, NoParams> {
  final AuthRepository authRepository;

  GetSignedInUser(this.authRepository);

  @override
  Future<SignedInUserEntity> call(NoParams params) {
    return authRepository.signedInUser;
  }
}
