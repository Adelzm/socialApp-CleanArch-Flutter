import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<UserEntity> getUser(String userId);
}
