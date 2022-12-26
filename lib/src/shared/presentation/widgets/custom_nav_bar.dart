import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      notchMargin: 10,
      child: SizedBox(
        height: 75,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          IconButton(
            onPressed: () {
              context.goNamed('feed');
            },
            iconSize: 30,
            icon: const Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              context.goNamed('discover');
            },
            iconSize: 30,
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              context.goNamed('add-content');
            },
            iconSize: 30,
            icon: const Icon(Icons.add_circle),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 30,
            icon: const Icon(Icons.message),
          ),
          IconButton(
            onPressed: () {
              context.goNamed('profile');
            },
            iconSize: 30,
            icon: const Icon(Icons.person),
          ),
        ]),
      ),
    );
  }
}
