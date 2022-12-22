import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_clean_archi/src/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:video_player/video_player.dart';

import '../../../../shared/presentation/widgets/custom_video_player.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is FeedLoaded) {
            return SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: state.posts.map((post) {
                  return CustomVideoPlayController(
                    assetPath: post.assetPath,
                    caption: post.caption,
                    username: post.user.username.value,
                  );
                }).toList(),
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Something went Wrong!',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        },
      ),
    );
  }
}
