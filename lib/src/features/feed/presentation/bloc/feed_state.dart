part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<PostEntity> posts;

  const FeedLoaded({this.posts = const <PostEntity>[]});

  @override
  List<Object> get props => [posts];
}
