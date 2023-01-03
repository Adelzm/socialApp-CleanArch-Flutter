import 'package:social_media_clean_archi/src/features/chat/domain/entities/message_entity.dart';

class MessageModel {
  final String chatId;
  final String senderId;
  final String recipientId;
  final String text;
  final DateTime createdAt;

  const MessageModel({
    required this.chatId,
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String chatId) {
    return MessageModel(
        chatId: chatId,
        senderId: json['senderId'],
        recipientId: json['recipientId'],
        text: json['text'],
        createdAt: json['createdAt']);
  }

  factory MessageModel.fromEntity(MessageEntity message) {
    return MessageModel(
        chatId: message.chatId,
        senderId: message.senderId,
        recipientId: message.recipientId,
        text: message.text,
        createdAt: message.createdAt);
  }

  MessageEntity toEntity() {
    return MessageEntity(
        chatId: chatId,
        senderId: senderId,
        recipientId: recipientId,
        text: text,
        createdAt: createdAt);
  }
}
