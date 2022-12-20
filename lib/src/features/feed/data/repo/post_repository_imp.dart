import 'package:social_media_clean_archi/src/features/feed/data/datasources/mock_feed_data_source.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/repo/post_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';

class PostRepositoryImp implements PostRepository {
  final MockFeedDataSource mockFeedDataSource;
  // TODO: add local data source using Hive
  PostRepositoryImp(this.mockFeedDataSource);

  @override
  Future<List<PostEntity>> getPosts() async {
    return mockFeedDataSource.getPosts();
  }

  @override
  Future<List<PostEntity>> getPostByUser(userId) async {
    return mockFeedDataSource.getPostsByUser(userId);
  }
}
