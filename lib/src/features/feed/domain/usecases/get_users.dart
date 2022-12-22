import 'package:social_media_clean_archi/src/features/feed/domain/repo/post_repository.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/repo/user_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class GetUsers implements UseCase<List<PostEntity>, NoParams> {
  final UserRepository postRepository;

  GetUsers(this.postRepository);

  @override
  Future<List<UserEntity>> call(NoParams params) {
    return postRepository.getUsers();
  }
}
