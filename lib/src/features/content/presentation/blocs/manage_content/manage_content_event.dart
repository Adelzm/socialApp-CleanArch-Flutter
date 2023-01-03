part of 'manage_content_bloc.dart';

abstract class ManageContentEvent extends Equatable {
  const ManageContentEvent();

  @override
  List<Object> get props => [];
}

class GetPostByUserEvent extends ManageContentEvent {
  final String userId;

  const GetPostByUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class DeletePostEvent extends ManageContentEvent {
  final PostEntity post;

  const DeletePostEvent({required this.post});

  @override
  List<Object> get props => [post];
}