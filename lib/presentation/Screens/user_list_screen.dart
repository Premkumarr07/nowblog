// lib/presentation/screens/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/user.dart';
import '../bloc/user/user_bloc.dart';
import '../widgets/user_card.dart';
import '../widgets/loading_widget.dart';
import '../widgets/error_widget.dart';
import 'create_post_screen.dart';

class UserListScreen extends StatefulWidget {
  final VoidCallback? onToggleTheme;
  final VoidCallback? onToggleColor;
  final bool isDarkMode;
  final bool isPrimaryColorBlue;

  const UserListScreen({
    Key? key,
    this.onToggleTheme,
    this.onToggleColor,
    this.isDarkMode = false,
    this.isPrimaryColorBlue = true,
  }) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<UserBloc>().add(FetchUsersEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<UserBloc>().add(FetchUsersEvent());
    }
  }

  void _onSearchChanged(String query) {
    context.read<UserBloc>().add(SearchUsersEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search users...',
            border: InputBorder.none,
          ),
          onChanged: _onSearchChanged,
        )
            : const Text('Users'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchController.clear();
                  _onSearchChanged('');
                }
              });
            },
          ),

          // Dark/Light mode toggle with sun/moon icon
          IconButton(
            icon: widget.isDarkMode
                ? const Icon(Icons.wb_sunny)
                : const Icon(Icons.nightlight_round),
            tooltip: 'Toggle Dark/Light Mode',
            onPressed: widget.onToggleTheme,
          ),

          // Primary color toggle with color lens icon
          IconButton(
            icon: widget.isPrimaryColorBlue
                ? const Icon(Icons.color_lens_outlined)
                : const Icon(Icons.color_lens),
            tooltip: 'Toggle Primary Color',
            onPressed: widget.onToggleColor,
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserInitial || state is UserLoading) {
            return const LoadingWidget();
          } else if (state is UserError) {
            return ErrorMessageWidget(message: state.message);
          } else if (state is UserLoaded) {
            return _buildUserList(state);
          } else {
            return const ErrorMessageWidget(message: 'Unexpected error');
          }
        },
      ),
    );
  }

  Widget _buildUserList(UserLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<UserBloc>().add(FetchUsersEvent());
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount:
        state.hasReachedMax ? state.users.length : state.users.length + 1,
        itemBuilder: (context, index) {
          if (index >= state.users.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final user = state.users[index];
          return UserCard(
            user: user,
            onCreatePost: () {
              context.push('/create-post/${user.id}');
            },
          );
        },
      ),
    );
  }
}
