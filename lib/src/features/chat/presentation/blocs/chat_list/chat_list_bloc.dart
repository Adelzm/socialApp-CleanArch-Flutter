import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/usecases/get_chat_by_user.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final GetChatByUser _getChatByUser;

  ChatListBloc(GetChatByUser getChatByUser)
      : _getChatByUser = getChatByUser,
        super(ChatListLoading()) {
    on<ChatListGetChats>(_onChatGetChats);
  }

  void _onChatGetChats(
      ChatListGetChats event, Emitter<ChatListState> emit) async {
    debugPrint('Start getting chats with _onChatGetChats');

    List<ChatEntity> chats =
        await _getChatByUser(GetChatByUserParams(userId: event.userId));

    chats.map((chat) {
      chat.messages!.sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
    });

    emit(ChatListLoaded(chats: chats));
  }
}
