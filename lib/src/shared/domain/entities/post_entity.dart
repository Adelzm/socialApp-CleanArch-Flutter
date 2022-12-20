import 'package:equatable/equatable.dart';

import 'user_entity.dart';

class PostEntity extends Equatable {
  final String id;
  final UserEntity user;
  final String caption;
  final String assetPath;

  const PostEntity(
      {required this.id,
      required this.user,
      required this.caption,
      required this.assetPath});

  @override
  List<Object?> get props => [id, user, caption, assetPath];
}
