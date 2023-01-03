import '../../../../shared/domain/entities/post_entity.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../../../feed/domain/repo/post_repository.dart';

class CreatePost implements UseCase<void, CreatePostParams> {
  final PostRepository postRepository;

  const CreatePost(this.postRepository);

  @override
  Future<void> call(CreatePostParams params) {
    return postRepository.createPost(params.post);
  }
}

class CreatePostParams extends Params {
  final PostEntity post;

  CreatePostParams({required this.post});

  @override
  List<Object?> get props => [post];
}
