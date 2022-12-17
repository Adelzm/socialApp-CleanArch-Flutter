import 'package:social_media_clean_archi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class SignoutUser implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  SignoutUser(this.authRepository);

  @override
  Future<void> call(NoParams params) {
    return authRepository.signout();
  }
}
