import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/chat_entity.dart';
import '../repos/chat_repo.dart';

class GetChatById implements UseCase<ChatEntity, GetChatByIdParams> {
  final ChatRepo chatRepo;

  GetChatById(this.chatRepo);

  @override
  Future<ChatEntity> call(GetChatByIdParams params) {
    return chatRepo.getChatById(params.userId, params.chatId);
  }
}

class GetChatByIdParams extends Params {
  final String userId;
  final String chatId;

  GetChatByIdParams({required this.userId, required this.chatId});

  @override
  List<Object?> get props => [userId, chatId];
}
