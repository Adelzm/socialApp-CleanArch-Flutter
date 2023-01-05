import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/chat_entity.dart';
import '../repos/chat_repo.dart';

class GetChatByUser implements UseCase<List<ChatEntity>, GetChatByUserParams> {
  final ChatRepo chatRepo;

  GetChatByUser(this.chatRepo);

  @override
  Future<List<ChatEntity>> call(GetChatByUserParams params) {
    return chatRepo.getChatsByUser(params.userId);
  }
}

class GetChatByUserParams extends Params {
  final String userId;

  GetChatByUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
