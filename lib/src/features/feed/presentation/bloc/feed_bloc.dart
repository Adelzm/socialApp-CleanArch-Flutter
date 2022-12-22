import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutteR_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/usecases/get_posts.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/usecases/usecases.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPosts _getPosts;

  FeedBloc({required GetPosts getPosts})
      : _getPosts = getPosts,
        super(FeedLoading()) {
    on<FeedGetPosts>(_onFeedGetPosts);
  }

  void _onFeedGetPosts(FeedGetPosts event, Emitter<FeedState> emit) async {
    debugPrint('Start getting posts with: _onFeedGetPosts');
    List<PostEntity> posts = await _getPosts(NoParams());
    emit(FeedLoaded(posts: posts));
  }
}
