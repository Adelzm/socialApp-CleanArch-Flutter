import '../../../../shared/domain/entities/post_entity.dart';
import '../../../../shared/domain/entities/user_entity.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repo/user_repository.dart';

class GetUser implements UseCase<List<PostEntity>, GetUserParams> {
  final UserRepository postRepository;

  GetUser(this.postRepository);

  @override
  Future<UserEntity> call(GetUserParams params) {
    return postRepository.getUser(params.userId);
  }
}

class GetUserParams extends Params {
  final String userId;

  GetUserParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
