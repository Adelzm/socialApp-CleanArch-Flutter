import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class UserEntity extends Equatable {
  final String id;
  final Username username;
  final int followrs;
  final int followings;
  final String? imagePath;

  const UserEntity(
      {required this.id,
      required this.username,
      this.followrs = 0,
      this.followings = 0,
      this.imagePath});

  static const empty = UserEntity(id: 'user_0', username: Username.pure());

  @override
  List<Object?> get props => [id, username, followrs, followings, imagePath];
}

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  // The pure constractor is used to initialize the value of the Username
  const Username.pure() : super.pure('');

  // We use dirty to update the value everytime the user enters a new string
  const Username.dirty([String value = '']) : super.dirty(value);

  // How we want the username to look like
  static final RegExp _usernameRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+$',
  );

  @override
  UsernameValidationError? validator(String value) {
    return _usernameRegExp.hasMatch(value)
        ? null
        : UsernameValidationError.invalid;
  }
}
