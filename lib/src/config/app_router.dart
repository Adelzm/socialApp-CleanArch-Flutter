import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clean_archi/main.dart';

class AppRouter {
  
  // ToDo: Add the auth bloc as an input
  AppRouter();

  /// The route configuration.
  late final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          // TODO: Change to feed screen.
          return const HomeScreen();
        }),
          GoRoute(
            name: 'discover',
            path: '/discover',
            builder: (BuildContext context, GoRouterState state) {
              return Container();
            },
            routes: [
              GoRoute(
                name: 'user',
                path: ':userId',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                }
                )
            ]
          ),
          GoRoute(
            name: 'login',
            path: '/login',
            builder: (BuildContext context, GoRouterState state) {
              return Container();
            },
            routes: [
              GoRoute(
                name: 'signup',
                path: ':singup',
                builder: (BuildContext context, GoRouterState state) {
                  return Container();
                }
                )
            ]
          ),
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