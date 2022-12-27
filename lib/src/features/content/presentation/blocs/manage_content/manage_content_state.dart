part of 'manage_content_bloc.dart';

abstract class ManageContentState extends Equatable {
  const ManageContentState();

  @override
  List<Object> get props => [];
}

class ManageContentLoading extends ManageContentState {}

class ManageContentLoaded extends ManageContentState {
  final List<PostEntity> posts;

  const ManageContentLoaded({required this.posts});

  @override
  List<Object> get props => [posts];
}
