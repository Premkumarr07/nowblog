import 'package:flutter/material.dart';
import '../../domain/entities/user.dart';
import 'package:go_router/go_router.dart';

class UserCard extends StatelessWidget {
  final User user;
  final VoidCallback? onCreatePost;

  const UserCard({
    Key? key,
    required this.user,
    this.onCreatePost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            user.firstName.isNotEmpty ? user.firstName[0].toUpperCase() : '?',
          ),
        ),
        title: Text('${user.firstName} ${user.lastName}'),
        subtitle: Text(user.email),
        onTap: () {
          // Navigate to user detail screen and pass user as extra data
          context.push('/user/${user.id}', extra: user);
        },
        trailing: IconButton(
          icon: const Icon(Icons.add),
          tooltip: 'Create Post',
          onPressed: onCreatePost,
        ),
      ),
    );
  }
}
