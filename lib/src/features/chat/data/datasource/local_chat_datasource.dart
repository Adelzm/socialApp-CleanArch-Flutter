import 'package:hive/hive.dart';
import 'package:social_media_clean_archi/src/features/chat/data/models/chat_model.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/entities/chat_entity.dart';

abstract class LocalChatDatasource {
  Future<void> addChat(ChatEntity chat);
  Future<ChatEntity?> getChatById(String chatId);
  Future<List<ChatEntity>> getChats();
  Future<void> updateChat(ChatEntity chat);
}

class LocalChatDatasourceImp implements LocalChatDatasource {
  String boxName = 'chats';
  Type boxType = ChatModel;

  @override
  Future<void> addChat(ChatEntity chat) async {
    Box box = await _openBox();
    await box.put(chat.id, ChatModel.fromEntity(chat));
  }

  @override
  Future<ChatEntity?> getChatById(String chatId) async {
    Box box = await _openBox();
    ChatModel? chatModel = await box.get(chatId);
    return (chatModel == null) ? null : chatModel.toEntity();
  }

  @override
  Future<List<ChatEntity>> getChats() async {
    Box<ChatModel> box = await _openBox() as Box<ChatModel>;
    return box.values
        .toList()
        .map(
          (chatModel) => chatModel.toEntity(),
        )
        .toList();
  }

  @override
  Future<void> updateChat(ChatEntity chat) async {
     Box box = await _openBox();
    await box.put(chat.id, ChatModel.fromEntity(chat));
  }

  Future<Box> _openBox() async {
    return Hive.openBox<ChatModel>(boxName);
  }
}
