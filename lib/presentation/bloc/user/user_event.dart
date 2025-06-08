part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

/// Event to fetch users with pagination
class FetchUsersEvent extends UserEvent {
  const FetchUsersEvent();

  @override
  List<Object> get props => [];
}

/// Event to search users by query
class SearchUsersEvent extends UserEvent {
  final String query;

  const SearchUsersEvent(this.query);

  @override
  List<Object> get props => [query];
}

/// Event to refresh users list (reset pagination)
class RefreshUsersEvent extends UserEvent {
  const RefreshUsersEvent();

  @override
  List<Object> get props => [];
}

/// Event to load more users (pagination)
class LoadMoreUsersEvent extends UserEvent {
  const LoadMoreUsersEvent();

  @override
  List<Object> get props => [];
}