part of 'chat_list_bloc.dart';

class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

class ChatListLoading extends ChatListState {}

class ChatListLoaded extends ChatListState {
  final List<ChatEntity> chats;

  const ChatListLoaded({required this.chats});
}
