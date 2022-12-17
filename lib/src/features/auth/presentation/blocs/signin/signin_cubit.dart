import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:social_media_clean_archi/src/features/auth/data/datasource/mock_auth_datasource.dart';

import '../../../../../shared/domain/entities/user_entity.dart';
import '../../../domain/entities/signedin_user_entity.dart';
import '../../../domain/usecases/signin_user.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final SigninUser _signinUser;

  SigninCubit({
    required SigninUser signinUser,
  })  : _signinUser = signinUser,
        super(SigninState.initial());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.username, password]),
      ),
    );
  }

  Future<void> signInWithCredentials() async {
    if (!state.status.isValid) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _signinUser(
        SigninUserParams(username: state.username, password: state.password),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on LoginWithUsernameAndPasswordFailure catch (e) {
      emit(state.copyWith(
          errorText: e.message, status: FormzStatus.submissionFailure));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
