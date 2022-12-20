import 'package:social_media_clean_archi/src/features/feed/domain/repo/post_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class GetPosts implements UseCase<List<PostEntity>, NoParams> {
  final PostRepository postRepository;

  GetPosts(this.postRepository);

  @override
  Future<List<PostEntity>> call(NoParams params) {
    return postRepository.getPosts();
  }
}
