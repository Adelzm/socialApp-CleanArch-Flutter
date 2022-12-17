import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_clean_archi/src/config/app_router.dart';
import 'package:social_media_clean_archi/src/features/auth/data/datasource/mock_auth_datasource.dart';
import 'package:social_media_clean_archi/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/usecases/get_auth_status.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/usecases/get_signedin_user.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/usecases/signin_user.dart';
import 'package:social_media_clean_archi/src/features/auth/domain/usecases/signout_user.dart';
import 'package:social_media_clean_archi/src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:social_media_clean_archi/src/features/auth/presentation/blocs/signin/signin_cubit.dart';

import 'src/config/app_theme.dart';
import 'src/features/auth/presentation/views/signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepositoryImpl(MockAuthDatasourceImpl()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              getAuthStatus: GetAuthStatus(
                context.read<AuthRepositoryImpl>(),
              ),
              getSignedInUser: GetSignedInUser(
                context.read<AuthRepositoryImpl>(),
              ),
              signoutUser: SignoutUser(
                context.read<AuthRepositoryImpl>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => SigninCubit(
              signinUser: SigninUser(context.read<AuthRepositoryImpl>()),
            ),
          ),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: CustomTheme().theme(),
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}
