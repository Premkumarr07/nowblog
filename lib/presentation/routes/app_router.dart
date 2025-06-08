import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/user_list_screen.dart';
import '../screens/user_detail_screen.dart';
import '../screens/create_post_screen.dart';
import '../../domain/entities/user.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const UserListScreen();
      },
    ),
    GoRoute(
      path: '/user/:id',
      builder: (BuildContext context, GoRouterState state) {
        final user = state.extra as User?;
        if (user == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('User data not found')),
          );
        }
        return UserDetailScreen(user: user);
      },
    ),
    GoRoute(
      path: '/create-post/:userId',
      builder: (BuildContext context, GoRouterState state) {
        final userId = int.tryParse(state.pathParameters['userId'] ?? '') ?? 0;
        return CreatePostScreen(userId: userId);
      },
    ),
  ], 
);
