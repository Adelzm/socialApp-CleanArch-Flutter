import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_clean_archi/src/features/auth/presentation/views/signup_screen.dart';
import 'package:social_media_clean_archi/src/features/feed/presentation/views/discover_screen.dart';
import 'package:social_media_clean_archi/src/features/feed/presentation/views/feed_screen.dart';

import '../features/auth/presentation/views/signin_screen.dart';

class AppRouter {
  // ToDo: Add the auth bloc as an input
  AppRouter();

  /// The route configuration.
  late final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          name: 'feed',
          path: '/feed',
          builder: (BuildContext context, GoRouterState state) {
            return const FeedScreen();
          }),
      GoRoute(
          name: 'discover',
          path: '/discover',
          builder: (BuildContext context, GoRouterState state) {
            return const DiscoverScreen();
          },
          routes: [
            GoRoute(
                name: 'user',
                path: ':userId',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                })
          ]),
      GoRoute(
          name: 'signin',
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInScreen();
          },
          routes: [
            GoRoute(
                name: 'signup',
                path: 'singup',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpScreen();
                })
          ]),
    ],
    // TODO: Redirect users to the login screen if they are not
    // authenticated. Else, go to the feed screen.
    //redirect:
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
