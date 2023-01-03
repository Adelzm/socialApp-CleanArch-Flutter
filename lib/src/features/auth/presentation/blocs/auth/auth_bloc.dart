import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../shared/domain/usecases/usecases.dart';
import '../../../data/datasource/mock_auth_datasource.dart';
import '../../../domain/entities/signed_in_user_entity.dart';
import '../../../domain/usecases/get_auth_status.dart';
import '../../../domain/usecases/get_signedin_user.dart';
import '../../../domain/usecases/signout_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Bring in the use cases
  final SignoutUser _signoutUser;
  final GetAuthStatus _getAuthStatus;
  final GetSignedInUser _getSignedInUser;

  late StreamSubscription<AuthStatus> _authStatusSubscription;

  AuthBloc({
    required SignoutUser signoutUser,
    required GetAuthStatus getAuthStatus,
    required GetSignedInUser getSignedInUser,
  })  : _signoutUser = signoutUser,
        _getAuthStatus = getAuthStatus,
        _getSignedInUser = getSignedInUser,
        super(const AuthState.unknown()) {
    on<AuthGetStatus>(_onAuthGetStatus);
    on<AuthSignOutUser>(_onAuthSignoutUser);

    _authStatusSubscription = _getAuthStatus(NoParams()).listen((status) {
      add(AuthGetStatus(status));
    });
  }

  Future<void> _onAuthGetStatus(
    AuthGetStatus event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('Get AuthGetStatus: ${event.status}');

    switch (event.status) {
      case AuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthStatus.unknow:
        return emit(const AuthState.unknown());
      case AuthStatus.authenticated:
        final user = await _getSignedInUser(NoParams());
        return emit(AuthState.authenticated(user: user));
    }
  }

  void _onAuthSignoutUser(
    AuthSignOutUser event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('User logout with _onauthLogoutUser');
    await _signoutUser(NoParams());
    emit(const AuthState.unauthenticated());
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}


