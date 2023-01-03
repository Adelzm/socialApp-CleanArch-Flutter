import 'package:hive_flutter/hive_flutter.dart';

import '../../../../shared/data/models/user_model.dart';
import '../../domain/entities/chat_entity.dart';
import 'message_model.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 3)
class ChatModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final UserModel currentUser;
  @HiveField(2)
  final UserModel otherUser;
  @HiveField(3)
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
