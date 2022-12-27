import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/entities/signed_in_user_entity.dart';
import 'package:social_media_clean_archi/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:social_media_clean_archi/src/features/content/presentation/blocs/manage_content/manage_content_bloc.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/post_entity.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignedInUserEntity user = context.read<AuthBloc>().state.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.username.value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<ManageContentBloc, ManageContentState>(
        builder: (context, state) {
          if (state is ManageContentLoading) {
            return const CircularProgressIndicator(
              color: Colors.white,
            );
          }
          if (state is ManageContentLoaded) {
            return DefaultTabController(
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
                      itemCount: state.posts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 9 / 16,
                      ),
                      itemBuilder: (context, index) {
                        return CustomVideoPlayer(
                            assetPath: state.posts[index].assetPath);
                      },
                    ),
                    Text('Tab 2'),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: Text(
              'Something Went Wrong',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        },
      ),
    );
  }
}
