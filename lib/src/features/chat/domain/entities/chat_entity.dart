import 'package:equatable/equatable.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

class ChatEntity extends Equatable {
  final String id;
  final UserEntity currentUser;
  final UserEntity otherUser;
  final List<MessageEntity>? messages;

  const ChatEntity({
    required this.id,
    required this.currentUser,
    required this.otherUser,
    this.messages,
  });

  @override
  List<Object?> get props => [
        id,
        currentUser,
        otherUser,
        messages,
      ];

  ChatEntity copyWith(String? id, UserEntity? currentUser,
      UserEntity? otherUser, List<MessageEntity>? messages) {
    return ChatEntity(
        id: id ?? this.id,
        currentUser: currentUser ?? this.currentUser,
        otherUser: otherUser ?? this.otherUser,
        messages: messages ?? this.messages);
  }
}
