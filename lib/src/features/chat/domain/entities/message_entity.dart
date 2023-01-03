import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String chatId;
  final String senderId;
  final String recipientId;
  final String text;
  final DateTime createdAt;

  const MessageEntity({
    required this.chatId,
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        chatId,
        senderId,
        recipientId,
        text,
        createdAt,
      ];
}
