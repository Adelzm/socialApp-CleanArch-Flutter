import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/signed_in_user_entity.dart';
import '../repository/auth_repository.dart';

class SigninUser implements UseCase<void, SigninUserParams> {
  final AuthRepository authRepository;

  SigninUser(this.authRepository);

  @override
  Future<void> call(SigninUserParams params) {
    // TODO: Add another repository to save the user into a database when they create an account.
    return authRepository.signin(
        username: params.username, password: params.password);
  }
}

class SigninUserParams extends Params {
  final Username username;
  final Password password;

  SigninUserParams({required this.username,required this.password});

  @override
  List<Object?> get props => [username, password];
}
