import 'package:social_media_clean_archi/src/shared/data/datasource/post_data.dart';
import 'package:social_media_clean_archi/src/shared/data/datasource/user_data.dart';
import 'package:social_media_clean_archi/src/shared/data/models/post_model.dart';
import 'package:social_media_clean_archi/src/shared/data/models/user_model.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

abstract class MockFeedDataSource {
  Future<List<PostEntity>> getPosts();
  Future<List<PostEntity>> getPostsByUser(String userId);
  Future<List<UserEntity>> getUsers();
  Future<UserEntity> getUser(String userId);
}

class MockFeedDataSourceImpl implements MockFeedDataSource {
  @override
  Future<List<PostEntity>> getPosts() async {
    await Future.delayed(const Duration(microseconds: 300));
    return posts.map((post) {
      Map<String, dynamic> user = users.where((user) {
        return user['id'] == post['userId'];
      }).first;
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }

  @override
  Future<List<PostEntity>> getPostsByUser(String userId) async {
    await Future.delayed(const Duration(microseconds: 300));
    return posts.where((post) {
      return post['userId' == userId];
    }).map((post) {
      Map<String, dynamic> user = users.where((user) {
        return user['id'] == post['userId'];
      }).first;
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }

  @override
  Future<List<UserEntity>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return users.map((user) {
      return UserModel.fromJson(user).toEntity();
    }).toList();
  }

  @override
  Future<UserEntity> getUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    Map<String, dynamic> user =
        users.where((user) => user['id'] == userId).first;
    return UserModel.fromJson(user).toEntity();
  }
}
