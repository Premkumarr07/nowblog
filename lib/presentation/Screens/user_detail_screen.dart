import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../presentation/bloc/post/post_bloc.dart';
import '../../presentation/bloc/todo/todo_bloc.dart';

class UserDetailScreen extends StatefulWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchUserPostsEvent(widget.user.id));

  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Scaffold(
      appBar: AppBar(title: Text(user.firstName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${user.firstName} ${user.lastName}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(user.email, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 24),

            /// Posts Section
            Text("Posts", style: Theme.of(context).textTheme.titleLarge),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoading) {
                  return const CircularProgressIndicator();
                } else if (state is PostError) {
                  return Text('Error loading posts: ${state.message}');
                } else if (state is PostLoaded) {
                  if (state.posts.isEmpty) {
                    return const Text('No posts found for this user.');
                  }
                  return Column(
                    children: state.posts
                        .map(
                          (post) => ListTile(
                        title: Text(post.title),
                        subtitle: Text(post.body),
                      ),
                    )
                        .toList(),
                  );
                }
                return const SizedBox();
              },
            ),

            const SizedBox(height: 24),

            /// Todos Section
            Text("Todos", style: Theme.of(context).textTheme.titleLarge),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const CircularProgressIndicator();
                } else if (state is TodoError) {
                  return Text('Error loading todos: ${state.message}');
                } else if (state is TodoLoaded) {
                  if (state.todos.isEmpty) {
                    return const Text('No todos found for this user.');
                  }
                  return Column(
                    children: state.todos
                        .map(
                          (todo) => CheckboxListTile(
                        value: todo.completed,
                        onChanged: null,
                        title: Text(todo.todo),
                      ),
                    )
                        .toList(),
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
