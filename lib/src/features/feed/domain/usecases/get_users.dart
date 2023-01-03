import '../../../../shared/domain/entities/post_entity.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repo/user_repository.dart';

class GetUsers implements UseCase<List<PostEntity>, NoParams> {
  final UserRepository postRepository;

  GetUsers(this.postRepository);

  @override
  Future<List<UserEntity>> call(NoParams params) {
    return postRepository.getUsers();
  }
}
