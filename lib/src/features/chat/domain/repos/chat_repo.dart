import 'package:social_media_clean_archi/src/features/chat/domain/entities/chat_entity.dart';

abstract class ChatRepo {
  Future<List<ChatEntity>> getChatsByUser(String userId);
  Future<ChatEntity> getChatById(String userId, String chatId);
  Future<void> updateChat(ChatEntity chat);
}
