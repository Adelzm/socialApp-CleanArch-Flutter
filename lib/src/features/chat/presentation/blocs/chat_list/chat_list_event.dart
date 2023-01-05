part of 'chat_list_bloc.dart';

class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

class ChatListGetChats extends ChatListEvent {
  final String userId;

  const ChatListGetChats({required this.userId});
}
