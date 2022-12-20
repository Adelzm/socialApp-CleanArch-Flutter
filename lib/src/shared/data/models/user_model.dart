import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String username;
  final int followrs;
  final int followings;
  final String? imagePath;

  const UserModel(
      {required this.id,
      required this.username,
      this.followrs = 0,
      this.followings = 0,
      this.imagePath});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      imagePath: json['imagePath'],
      followings: json['followings'],
      followrs: json['followrs'],
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      id: userEntity.id,
      username: userEntity.username.value,
      imagePath: userEntity.imagePath,
      followings: userEntity.followings,
      followrs: userEntity.followrs,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: Username.dirty(username),
      imagePath: imagePath,
      followings: followings,
      followrs: followrs,
    );
  }
}
