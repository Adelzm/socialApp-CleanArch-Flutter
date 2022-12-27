import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_clean_archi/src/features/feed/domain/usecases/get_posts_by_user_id.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';

part 'manage_content_event.dart';
part 'manage_content_state.dart';

class ManageContentBloc extends Bloc<ManageContentEvent, ManageContentState> {
  final GetPostsByUser _getPostsByUser;

  ManageContentBloc({required GetPostsByUser getPostsByUser})
      : _getPostsByUser = getPostsByUser,
        super(ManageContentLoading()) {
    on<GetPostByUserEvent>(_onManageContentGetPostByUser);
  }

  Future<void> _onManageContentGetPostByUser(
      GetPostByUserEvent event, Emitter<ManageContentState> emit) async {
    final List<PostEntity> posts =
        await _getPostsByUser(GetPostsByUserParams(userId: event.userId));

    emit(ManageContentLoaded(posts: posts));
  }
}
