import 'package:social_media_clean_archi/src/features/auth/domain/entities/signedin_user_entity.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class SignupUser implements UseCase<void, SignupUserParams> {
  final AuthRepository authRepository;

  SignupUser(this.authRepository);

  @override
  Future<void> call(SignupUserParams params) {
    return authRepository.signup(
        signedInUser: params.user);
  }
}

class SignupUserParams extends Params {
  final SignedInUserEntity user;

  SignupUserParams(this.user);

  @override
  List<Object?> get props => [user];
}
