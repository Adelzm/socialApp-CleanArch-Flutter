import 'package:social_media_clean_archi/src/features/chat/data/models/message_model.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_clean_archi/src/shared/data/models/user_model.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

class ChatModel {
  final String id;
  final UserModel currentUser;
  final UserModel otherUser;
  final List<MessageModel>? messages;

  const ChatModel({
    required this.id,
    required this.currentUser,
    required this.otherUser,
    this.messages,
  });

  factory ChatModel.fromJson(
    Map<String, dynamic> json,
    Map<String, dynamic> currentUser,
    Map<String, dynamic> otherUser,
  ) {
    return ChatModel(
      id: json['id'],
      currentUser: UserModel.fromJson(currentUser),
      otherUser: UserModel.fromJson(otherUser),
      messages: (json['messages'] as List).map((message) {
        return MessageModel.fromJson(message, json['id']);
      }).toList(),
    );
  }

  factory ChatModel.fromEntity(ChatEntity chat) {
    return ChatModel(
      id: chat.id,
      currentUser: UserModel.fromEntity(chat.currentUser),
      otherUser: UserModel.fromEntity(chat.otherUser),
      messages: chat.messages!.map((message) {
        return MessageModel.fromEntity(message);
      }).toList(),
    );
  }

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      currentUser: currentUser.toEntity(),
      otherUser: otherUser.toEntity(),
      messages: messages!.map((message) => message.toEntity()).toList(),
    );
  }
}
