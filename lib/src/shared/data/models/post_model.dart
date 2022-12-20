import 'package:social_media_clean_archi/src/shared/data/models/user_model.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';

class PostModel {
  final String id;
  final UserModel userModel;
  final String caption;
  final String assetPath;

  PostModel(
      {required this.id,
      required this.userModel,
      required this.caption,
      required this.assetPath});

  factory PostModel.fromJson(
      Map<String, dynamic> post, Map<String, dynamic> user) {
    return PostModel(
        id: post['id'],
        userModel: UserModel.fromJson(user),
        caption: post['caption'],
        assetPath: post['assetPath']);
  }

  factory PostModel.fromEntity(PostEntity post) {
    return PostModel(
        id: post.id,
        userModel: UserModel.fromEntity(post.user),
        caption: post.caption,
        assetPath: post.assetPath);
  }

  PostEntity toEntity() {
    return PostEntity(
        id: id,
        user: userModel.toEntity(),
        caption: caption,
        assetPath: assetPath);
  }
}
