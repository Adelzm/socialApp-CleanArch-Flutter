import 'package:social_media_clean_archi/src/features/feed/domain/repo/post_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class GetPostsByUser
    implements UseCase<List<PostEntity>, GetPostsByUserParams> {
  final PostRepository postRepository;

  GetPostsByUser(this.postRepository);

  @override
  Future<List<PostEntity>> call(GetPostsByUserParams params) {
    return postRepository.getPostByUser(params.userId);
  }
}

class GetPostsByUserParams extends Params {
  final String userId;

  GetPostsByUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
