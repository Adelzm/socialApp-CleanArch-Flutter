import 'package:hive/hive.dart';
import 'package:social_media_clean_archi/src/shared/data/models/post_model.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

abstract class LocalFeedDatasource {
  Future<void> addPosts(PostEntity post);
  Future<void> deleteAllPosts();
  Future<List<PostEntity>> getPosts();
  Future<List<PostEntity>> getPostsByUser(String userId);
}

class LocalFeedDatasourceImp implements LocalFeedDatasource {
  String boxName = 'posts';
  Type boxType = PostModel;

  @override
  Future<void> addPosts(PostEntity post) async {
    Box box = await _openBox();
    await box.put(post.id, PostModel.fromEntity(post));
  }

  @override
  Future<void> deleteAllPosts() async {
    Box box = await _openBox();
    await box.clear();
  }

  @override
  Future<List<PostEntity>> getPosts() async {
    Box<PostModel> box = await _openBox() as Box<PostModel>;
    return box.values.toList().map((post) => post.toEntity()).toList();
  }

  Future<Box> _openBox() async {
    return Hive.openBox<PostModel>(boxName);
  }

  @override
  Future<List<PostEntity>> getPostsByUser(String userId) async {
    Box<PostModel> box = await _openBox() as Box<PostModel>;
    return box.values
        .where((post) => post.userModel.id == userId)
        .toList()
        .map((post) => post.toEntity())
        .toList();
  }
}
