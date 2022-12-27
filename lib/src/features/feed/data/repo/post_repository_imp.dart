import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/src/features/feed/data/datasources/local_feed_datasource.dart';
import 'package:social_media_clean_archi/src/features/feed/data/datasources/mock_feed_data_source.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/repo/post_repository.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';

class PostRepositoryImp implements PostRepository {
  final MockFeedDataSource mockFeedDataSource;
  final LocalFeedDatasource localFeedDatasource;
  PostRepositoryImp(this.mockFeedDataSource, this.localFeedDatasource);

  @override
  Future<List<PostEntity>> getPosts() async {
    // TODO: Check interenet connection. Get form database
    // if there is an active connection. Else get from local Hive.

    if ((await localFeedDatasource.getPosts()).isEmpty) {
      List<PostEntity> posts = await mockFeedDataSource.getPosts();
      for (final post in posts) {
        localFeedDatasource.addPosts(post);
      }
      return posts;
    } else {
      debugPrint('Retrieving data form Hive');
      return localFeedDatasource.getPosts();
    }
  }

  @override
  Future<List<PostEntity>> getPostByUser(userId) async {
    //return mockFeedDataSource.getPostsByUser(userId);
    if ((await localFeedDatasource.getPostsByUser(userId)).isEmpty) {
      List<PostEntity> posts = await mockFeedDataSource.getPostsByUser(userId);
      for (final post in posts) {
        localFeedDatasource.addPosts(post);
      }
      return posts;
    } else {
      debugPrint('Retrieving data form Hive');
      return localFeedDatasource.getPostsByUser(userId);
    }
  }

  @override
  Future<void> createPost(PostEntity post) {
    return localFeedDatasource.addPosts(post);
  }
}
