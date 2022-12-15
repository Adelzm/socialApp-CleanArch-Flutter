import 'package:flutter/material.dart';
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
      body: Container(),
    );
  }
}
