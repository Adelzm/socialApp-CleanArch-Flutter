import 'package:social_media_clean_archi/src/features/auth/data/datasource/mock_auth_datasource.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class GetAuthStatus implements UseCase<AuthStatus, NoParams> {
  final AuthRepository authRepository;

  GetAuthStatus(this.authRepository);

  @override
  Stream<AuthStatus> call(NoParams params) {
    return authRepository.status;
  }
}
