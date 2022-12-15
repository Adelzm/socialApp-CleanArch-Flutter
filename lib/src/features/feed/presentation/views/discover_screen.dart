import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/src/shared/presentation/widgets/custom_nav_bar.dart';

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
      body: Container(),
    );
  }
}
