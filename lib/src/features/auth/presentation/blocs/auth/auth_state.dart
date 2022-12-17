part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final AuthStatus status;
  final SignedInUserEntity user;

  const AuthState._({
    this.status = AuthStatus.unknow,
    this.user = SignedInUserEntity.empty,
  });

  const AuthState.unknown() : this._();

  const AuthState.authenticated({required SignedInUserEntity user})
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object> get props => [status, user];
}
