import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_clean_archi/src/features/content/domain/usecases/create_post.dart';
import 'dart:io';

import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

part 'add_content_state.dart';

class AddContentCubit extends Cubit<AddContentState> {
  final CreatePost _createPost;

  AddContentCubit(final CreatePost createPost)
      : _createPost = createPost,
        super(AddContentState.initialize());

  void videoChanged(File file) {
    emit(state.copyWith(video: file, status: AddContentStatus.loading));
  }

  void captionChanged(String caption) {
    emit(state.copyWith(caption: caption, status: AddContentStatus.loading));
  }

  void submit(UserEntity user) {
    try {
      final post = PostEntity(
          id: const Uuid().v1(),
          user: user,
          caption: state.caption,
          assetPath: state.video!.path);

      _createPost(CreatePostParams(post: post));
      debugPrint('The post has been created.');
      emit(state.copyWith(status: AddContentStatus.success));
    } catch (e) {}
  }

  void reset() {
    emit(AddContentState.initialize());
  }
}
