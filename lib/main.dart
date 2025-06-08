// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'theme/theme_wrapper.dart';
import 'theme/light_theme.dart';
import 'theme/dart_theme.dart';

import 'data/data_sources/user_remote_data_source.dart';
import 'data/data_sources/post_remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/fetch_users.dart';
import 'domain/usecases/search_user.dart';
import 'domain/usecases/get_user_posts.dart';
import 'domain/usecases/get_user_todos.dart';
import 'presentation/bloc/user/user_bloc.dart';
import 'presentation/bloc/post/post_bloc.dart';
import 'presentation/bloc/todo/todo_bloc.dart';
import 'presentation/bloc/create_post/create_post_bloc.dart';
import 'presentation/routes/app_router.dart';

void main() {
  runApp(const ThemeWrapper(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final httpClient = http.Client();

    final userRemoteDataSource = UserRemoteDataSourceImpl(client: httpClient);
    final postRemoteDataSource = PostRemoteDataSourceImpl(client: httpClient);

    final userRepository = UserRepositoryImpl(
      userRemoteDataSource: userRemoteDataSource,
      postRemoteDataSource: postRemoteDataSource,
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => userRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(
              fetchUsers: FetchUsers(context.read<UserRepository>()),
              searchUsers: SearchUsers(context.read<UserRepository>()),
            ),
          ),
          BlocProvider<PostBloc>(
            create: (context) => PostBloc(
              getUserPosts: GetUserPosts(context.read<UserRepository>()),
            ),
          ),
          BlocProvider<TodoBloc>(
            create: (context) => TodoBloc(
              getUserTodos: GetUserTodos(context.read<UserRepository>()),
            ),
          ),
          BlocProvider<CreatePostBloc>(
            create: (context) => CreatePostBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            final isDark = ThemeWrapper.of(context).isDarkMode;
            return MaterialApp.router(
              title: 'User Management',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
