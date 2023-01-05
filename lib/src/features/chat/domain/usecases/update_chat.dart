import 'package:social_media_clean_archi/src/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_clean_archi/src/features/chat/domain/repos/chat_repo.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class UpdateChat implements UseCase<void, UpdateChatParams> {
  final ChatRepo chatRepo;

  UpdateChat(this.chatRepo);

  @override
  Future<void> call(params) {
    return chatRepo.updateChat(params.chat);
  }
}

class UpdateChatParams extends Params {
  final ChatEntity chat;

  UpdateChatParams({required this.chat});

  @override
  List<Object?> get props => [chat];
}
