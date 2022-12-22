import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_clean_archi/src/features/feed/presentation/bloc/feed_bloc.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/custom_nav_bar.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
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
            print(state.posts);
            return const Center(
              child: Text(
                'Feed Loaded',
                style: TextStyle(color: Colors.white),
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
