import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_media_clean_archi/src/features/chat/data/models/chat_model.dart';
import 'package:social_media_clean_archi/src/features/chat/data/models/message_model.dart';
import 'package:social_media_clean_archi/src/features/feed/data/datasources/local_feed_datasource.dart';
import 'package:social_media_clean_archi/src/shared/data/models/post_model.dart';
import 'package:social_media_clean_archi/src/shared/data/models/user_model.dart';

import 'src/config/app_router.dart';
import 'src/config/app_theme.dart';
import 'src/features/auth/data/datasource/mock_auth_datasource.dart';
import 'src/features/auth/data/repository/auth_repository_impl.dart';
import 'src/features/auth/domain/usecases/get_auth_status.dart';
import 'src/features/auth/domain/usecases/get_signedin_user.dart';
import 'src/features/auth/domain/usecases/signin_user.dart';
import 'src/features/auth/domain/usecases/signout_user.dart';
import 'src/features/auth/domain/usecases/signup_user.dart';
import 'src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/features/auth/presentation/blocs/signin/signin_cubit.dart';
import 'src/features/auth/presentation/blocs/signup/signup_cubit.dart';
import 'src/features/feed/data/datasources/mock_feed_data_source.dart';
import 'src/features/feed/data/repo/post_repository_imp.dart';
import 'src/features/feed/data/repo/user_repository_imp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
  Hive.registerAdapter(MessageModelAdapter());
  Hive.registerAdapter(ChatModelAdapter());
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
          create: (context) => AuthRepositoryImpl(
            MockAuthDatasourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PostRepositoryImp(
            MockFeedDataSourceImpl(),
            LocalFeedDatasourceImp(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepositoryImp(
            MockFeedDataSourceImpl(),
          ),
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
          BlocProvider(
            create: (context) => SignupCubit(
              signupUser: SignupUser(context.read<AuthRepositoryImpl>()),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: CustomTheme().theme(),
            routerConfig: AppRouter(context.read<AuthBloc>()).router,
          );
        }),
      ),
    );
  }
}
