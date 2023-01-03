import 'package:social_media_clean_archi/src/features/chat/data/models/chat_model.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_clean_archi/src/shared/data/datasource/chat_data.dart';
import 'package:social_media_clean_archi/src/shared/data/datasource/user_data.dart';

abstract class MockChatDatasource {
  Future<List<ChatEntity>> getChatsByUser(String userId);
  Future<ChatEntity> getChatById(String userId, String chatId);
  Future<void> updateChat(ChatEntity chat);
}

class MockChatDatasourceImpl implements MockChatDatasource {
  @override
  Future<List<ChatEntity>> getChatsByUser(String userId) async {
    await Future.delayed(const Duration(microseconds: 300));

    return chats
        .where(
      (chat) => (chat['userIds'] as List).contains(userId),
    )
        .map((chat) {
      String currentUserId = userId;
      String otherUserId = (chat['userIds'] as List)
          .where(
            (id) => id != currentUserId,
          )
          .first;
      Map<String, dynamic> currentUser = users
          .where(
            (user) => user['id'] == currentUserId,
          )
          .first;
      Map<String, dynamic> otherUser = users
          .where(
            (user) => user['id'] == otherUserId,
          )
          .first;

      return ChatModel.fromJson(
        chat,
        currentUser,
        otherUser,
      ).toEntity();
    }).toList();
  }

  @override
  Future<ChatEntity> getChatById(String userId, String chatId) async {
    await Future.delayed(const Duration(microseconds: 300));

    return chats.where((chat) => chat['id'] == chatId).map((chat) {
      String currentUserId = userId;
      String otherUserId = (chat['userIds'] as List)
          .where(
            (id) => id != currentUserId,
          )
          .first;
      Map<String, dynamic> currentUser = users
          .where(
            (user) => user['id'] == currentUserId,
          )
          .first;
      Map<String, dynamic> otherUser = users
          .where(
            (user) => user['id'] == otherUserId,
          )
          .first;

      return ChatModel.fromJson(
        chat,
        currentUser,
        otherUser,
      ).toEntity();
    }).first;
  }

  @override
  Future<void> updateChat(ChatEntity chat) {
    // TODO: implement updateChat
    throw UnimplementedError();
  }
}
