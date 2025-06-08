import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/fetch_users.dart';
import '../../../domain/usecases/search_user.dart';


part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FetchUsers fetchUsers;
  final SearchUsers searchUsers;

  UserBloc({
    required this.fetchUsers,
    required this.searchUsers,
  }) : super(UserInitial()) {
    on<FetchUsersEvent>(_onFetchUsers);
    on<SearchUsersEvent>(_onSearchUsers);
  }

  List<User> _users = [];
  bool _hasReachedMax = false;
  int _skip = 0;
  final int _limit = 10;

  Future<void> _onFetchUsers(
      FetchUsersEvent event,
      Emitter<UserState> emit,
      ) async {
    if (state is UserLoading) return;

    try {
      if (!_hasReachedMax) {
        emit(UserLoading());

        final result = await fetchUsers(limit: _limit, skip: _skip);

        result.fold(
              (failure) => emit(UserError(failure.message)),
              (users) {
            if (users.isEmpty) {
              _hasReachedMax = true;
              emit(UserLoaded(users: _users, hasReachedMax: true));
            } else {
              _users.addAll(users);
              _skip += _limit;
              emit(UserLoaded(users: _users, hasReachedMax: false));
            }
          },
        );
      }
    } catch (_) {
      emit(const UserError('Failed to fetch users'));
    }
  }

  Future<void> _onSearchUsers(
      SearchUsersEvent event,
      Emitter<UserState> emit,
      ) async {
    if (event.query.isEmpty) {
      _users.clear();
      _skip = 0;
      _hasReachedMax = false;
      add(FetchUsersEvent());
      return;
    }

    emit(UserLoading());
    try {
      final result = await searchUsers(event.query);
      result.fold(
            (failure) => emit(UserError(failure.message)),
            (users) => emit(UserLoaded(users: users, hasReachedMax: true)),
      );
    } catch (_) {
      emit(const UserError('Failed to search users'));
    }
  }
}
