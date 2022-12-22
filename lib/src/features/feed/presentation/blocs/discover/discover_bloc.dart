import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/usecases/get_users.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

part 'discover_event.dart';
part 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final GetUsers _getUsers;

  DiscoverBloc({required GetUsers getUsers})
      : _getUsers = getUsers,
        super(DiscoverLoading()) {
    on<DiscoverEvent>(_onDiscoverGetUsers);
  }

  void _onDiscoverGetUsers(
      DiscoverEvent event, Emitter<DiscoverState> emit) async {
    debugPrint('Start getting users with: _onDiscoverGetUsers');
    List<UserEntity> users = await _getUsers(NoParams());

    emit(DiscoverLoaded(users: users));
  }
}
