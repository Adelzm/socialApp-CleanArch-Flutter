import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_clean_archi/src/shared/domain/entities/user_entity.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/widgets.dart';

import '../../../../shared/presentation/widgets/custom_nav_bar.dart';
import '../blocs/discover/discover_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (state is DiscoverLoaded) {
            return MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  UserEntity user = state.users[index];
                  return Stack(
                    children: [
                      _DiscoverUSerCard(
                        user: user,
                        index: index,
                      ),
                      const CustomGradientOverlay(
                        stops: [0.4, 1.0],
                        colors: [Colors.transparent, Colors.black],
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: (user.imagePath == null)
                                  ? null
                                  : AssetImage(user.imagePath!),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              user.username.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                });
          } else {
            return Text('Error!');
          }
        },
      ),
    );
  }
}

class _DiscoverUSerCard extends StatelessWidget {
  const _DiscoverUSerCard({Key? key, required this.user, required this.index})
      : super(key: key);

  final UserEntity user;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (index == 0) ? 250 : 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: (user.imagePath == null)
              ? const AssetImage('assets/image_1.jpg')
              : AssetImage(user.imagePath!),
        ),
      ),
    );
  }
}
