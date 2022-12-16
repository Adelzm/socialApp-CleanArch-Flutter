import 'package:formz/formz.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

class SignedInUserEntity extends UserEntity {
  final Email? email;

  const SignedInUserEntity(
      {required super.id,
      required super.username,
      required this.email,
      super.followings,
      super.followrs,
      super.imagePath});

  static const empty =
      SignedInUserEntity(id: '_', username: Username.pure(), email: Email.pure());

  @override
  List<Object?> get props =>
      [id, username, email, followrs, followings, imagePath];

  SignedInUserEntity copyWith(String? id, Username? username, Email? email,
      int? followings, int? followrs, String? imagePath) {
    return SignedInUserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      followings: followings ?? this.followings,
      followrs: followrs ?? this.followrs,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  // The pure constractor is used to initialize the value of the Username
  const Email.pure() : super.pure('');

  // We use dirty to update the value everytime the user enters a new string
  const Email.dirty([String value = '']) : super.dirty(value);

  // How we want the username to look like
  static final RegExp _emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`~{}|-]+@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9-]+)*$');

  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  // The pure constractor is used to initialize the value of the Username
  const Password.pure() : super.pure('');

  // We use dirty to update the value everytime the user enters a new string
  const Password.dirty([String value = '']) : super.dirty(value);

  // How we want the username to look like
  static final RegExp _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
