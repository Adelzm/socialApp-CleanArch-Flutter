import 'package:hive/hive.dart';

import '../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final int followrs;
  @HiveField(3)
  final int followings;
  @HiveField(4)
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
      followrs: json['followers'],
    );
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
      id: userEntity.id,
      username: userEntity.username.value,
      imagePath: userEntity.imagePath,
      followings: userEntity.followings,
      followrs: userEntity.followers,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      username: Username.dirty(username),
      imagePath: imagePath,
      followings: followings,
      followers: followrs,
    );
  }
}
