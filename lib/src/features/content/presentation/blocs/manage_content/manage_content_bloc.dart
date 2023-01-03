import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_clean_archi/src/features/content/domain/usecases/delete_post.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/usecases/get_posts_by_user_id.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';

part 'manage_content_event.dart';
part 'manage_content_state.dart';

class ManageContentBloc extends Bloc<ManageContentEvent, ManageContentState> {
  final GetPostsByUser _getPostsByUser;
  final DeletePostById _deletePostById;

  ManageContentBloc(
      {required GetPostsByUser getPostsByUser,
      required DeletePostById deletePostById})
      : _getPostsByUser = getPostsByUser,
        _deletePostById = deletePostById,
        super(ManageContentLoading()) {
    on<GetPostByUserEvent>(_onManageContentGetPostByUser);
    on<DeletePostEvent>(_onManageContentDeletePost);
  }

  Future<void> _onManageContentGetPostByUser(
      GetPostByUserEvent event, Emitter<ManageContentState> emit) async {
    final List<PostEntity> posts =
        await _getPostsByUser(GetPostsByUserParams(userId: event.userId));

    emit(ManageContentLoaded(posts: posts));
  }

  Future<void> _onManageContentDeletePost(
      DeletePostEvent event, Emitter<ManageContentState> emit) async {
    if (state is ManageContentLoaded) {
      final state = this.state as ManageContentLoaded;

      await _deletePostById(DeletePostByIdParams(postId: event.post.id));
      List<PostEntity> posts = List.from(state.posts)..remove(event.post);
      emit(ManageContentLoaded(posts: posts));
    }
  }
}
