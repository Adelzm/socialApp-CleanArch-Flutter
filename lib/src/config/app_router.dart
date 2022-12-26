import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_clean_archi/src/features/auth/data/datasource/mock_auth_datasource.dart';
import 'package:social_media_clean_archi/src/features/content/domain/usecases/create_post.dart';
import 'package:social_media_clean_archi/src/features/content/presentation/blocs/add_content/add_content_cubit.dart';
import 'package:social_media_clean_archi/src/features/content/presentation/views/add_content_screen.dart';
import 'package:social_media_clean_archi/src/features/content/presentation/views/manage_content_screen.dart';

import '../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../features/auth/presentation/views/signin_screen.dart';
import '../features/auth/presentation/views/signup_screen.dart';
import '../features/feed/data/repo/post_repository_imp.dart';
import '../features/feed/data/repo/user_repository_imp.dart';
import '../features/feed/domain/usecases/get_posts.dart';
import '../features/feed/domain/usecases/get_users.dart';
import '../features/feed/presentation/blocs/discover/discover_bloc.dart';
import '../features/feed/presentation/blocs/feed/feed_bloc.dart';
import '../features/feed/presentation/views/discover_screen.dart';
import '../features/feed/presentation/views/feed_screen.dart';

class AppRouter {
  final AuthBloc authBloc;
  AppRouter(this.authBloc);

  /// The route configuration.
  late final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          name: 'feed',
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => FeedBloc(
                getPosts: GetPosts(
                  context.read<PostRepositoryImp>(),
                ),
              )..add(FeedGetPosts()),
              child: const FeedScreen(),
            );
          }),
      GoRoute(
          name: 'discover',
          path: '/discover',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => DiscoverBloc(
                getUsers: GetUsers(context.read<UserRepositoryImp>()),
              )..add(DiscoverGetUsers()),
              child: const DiscoverScreen(),
            );
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
          name: 'add-content',
          path: '/add-content',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => AddContentCubit(
                CreatePost(
                  context.read<PostRepositoryImp>(),
                ),
              ),
              child: const AddContentScreen(),
            );
          }),
      GoRoute(
          name: 'profile',
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfileScreen();
          }),
      GoRoute(
          name: 'signin',
          path: '/signin',
          builder: (BuildContext context, GoRouterState state) {
            return const SignInScreen();
          },
          routes: [
            GoRoute(
                name: 'signup',
                path: 'signup',
                builder: (BuildContext context, GoRouterState state) {
                  return const SignUpScreen();
                })
          ]),
    ],
    // redirect: (BuildContext context, GoRouterState state) {
    //   const signinLocation = '/signin';
    //   const signupLocation = '/signin/signup';

    //   final bool isSignedIn = authBloc.state.status == AuthStatus.authenticated;

    //   final isSigningIn = state.subloc == signinLocation;
    //   final isSigningUp = state.subloc == signupLocation;

    //   if (!isSignedIn && !isSigningIn && !isSigningUp) {
    //     return '/signin';
    //   }

    //   if (isSignedIn && isSigningIn) {
    //     return '/';
    //   }

    //   if (isSignedIn && isSigningUp) {
    //     return '/';
    //   }
    //   return null;
    // },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
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
