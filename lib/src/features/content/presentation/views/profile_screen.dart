import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const UserEntity user = UserEntity.empty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'user.username.value',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  CustomUserInformation(user: user),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed('add-content');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF006E),
                          fixedSize: const Size(150, 50),
                        ),
                        child: Text(
                          'Add a Video',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF006E),
                          fixedSize: const Size(150, 50),
                        ),
                        child: Text(
                          'Update Picture',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const TabBar(indicatorColor: Colors.white, tabs: [
                    Tab(icon: Icon(Icons.grid_view_rounded)),
                    Tab(icon: Icon(Icons.favorite)),
                  ])
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  PostEntity post = const PostEntity(
                      id: 'id',
                      user: user,
                      caption: 'Test',
                      assetPath: 'assets/videos/video_2.mp4');

                  return CustomVideoPlayer(assetPath: post.assetPath);
                },
              ),
              Text('Tab 2'),
            ],
          ),
        ),
      ),
    );
  }
}
