import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
  Future<List<PostEntity>> getPostByUser(userId);
  Future<void> createPost(PostEntity post);
}
