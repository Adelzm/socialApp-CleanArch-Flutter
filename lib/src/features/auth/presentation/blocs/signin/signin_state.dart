part of 'signin_cubit.dart';

class SigninState extends Equatable {
  final Username username;
  final Password password;
  final FormzStatus status;
  final String? errorText;

  const SigninState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorText,
  });

  factory SigninState.initial() {
    return const SigninState(
      username: Username.pure(),
      password: Password.pure(),
      status: FormzStatus.pure,
      errorText: null,
    );
  }

  SigninState copyWith({
    Username? username,
    Password? password,
    FormzStatus? status,
    String? errorText,
  }) {
    return SigninState(
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
        errorText: errorText ?? this.errorText);
  }

  @override
  List<Object?> get props => [username, password, status, errorText];
}
