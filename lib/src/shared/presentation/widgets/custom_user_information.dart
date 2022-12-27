import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';


class CustomUserInformation extends StatelessWidget {
  const CustomUserInformation({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          backgroundImage: (user.imagePath == null)
              ? null
              : AssetImage(
                  user.imagePath!,
                ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildUserInfo(context, 'Followers', '${user.followers}'),
              _buildUserInfo(context, 'Followings', '${user.followings}'),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildUserInfo(
    BuildContext context,
    String type,
    String value,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          type,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(letterSpacing: 1.5),
        ),
      ],
    );
  }
}
