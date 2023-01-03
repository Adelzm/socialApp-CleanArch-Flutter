import 'package:social_media_clean_archi/src/features/feed/domain/repo/post_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

class DeletePostById implements UseCase<void, DeletePostByIdParams> {
  final PostRepository postRepository;

  DeletePostById(this.postRepository);

  @override
  Future<void> call(DeletePostByIdParams params) {
    return postRepository.deletePostById(params.postId);
  }
}

class DeletePostByIdParams extends Params {
  final String postId;

  DeletePostByIdParams({required this.postId});

  @override
  List<Object?> get props => [postId];
}
