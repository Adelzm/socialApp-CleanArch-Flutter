import 'package:social_media_clean_archi/src/features/chat/data/datasource/local_chat_datasource.dart';
import 'package:social_media_clean_archi/src/features/chat/data/datasource/mock_chat_datasource.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/repos/chat_repo.dart';

class ChatRepoImp implements ChatRepo {
  final MockChatDatasource chatDatasource;
  final LocalChatDatasource localChatDatasource;

  ChatRepoImp(this.chatDatasource, this.localChatDatasource);

  @override
  Future<ChatEntity> getChatById(String userId, String chatId) async {
    // ToDo: Check for updates form remote database
    ChatEntity? chat = await localChatDatasource.getChatById(chatId);
    if (chat == null) {
      return chatDatasource.getChatById(userId, chatId);
    } else {
      print('We are using out local data source');
      return chat;
    }
  }

  @override
  Future<List<ChatEntity>> getChatsByUser(String userId) async {
    if ((await localChatDatasource.getChats()).isEmpty) {
      List<ChatEntity> chats = await chatDatasource.getChatsByUser(userId);
      for (final chat in chats) {
        localChatDatasource.addChat(chat);
      }
      return chats;
    } else {
      print('We are using out local data source');
      return localChatDatasource.getChats();
    }
  }

  @override
  Future<void> updateChat(ChatEntity chat) {
    // ToDo: Update the chat in the remote datasource
    return localChatDatasource.updateChat(chat);
  }
}
