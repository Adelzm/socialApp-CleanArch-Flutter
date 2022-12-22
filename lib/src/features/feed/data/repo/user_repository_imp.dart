import 'package:social_media_clean_archi/src/features/feed/data/datasources/mock_feed_data_source.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/repo/user_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

class UserRepositoryImp implements UserRepository {
  final MockFeedDataSource mockFeedDataSource;

  UserRepositoryImp(this.mockFeedDataSource);

  @override
  Future<UserEntity> getUser(String userId) {
    return mockFeedDataSource.getUser(userId);
  }

  @override
  Future<List<UserEntity>> getUsers() {
    return mockFeedDataSource.getUsers();
  }
}
