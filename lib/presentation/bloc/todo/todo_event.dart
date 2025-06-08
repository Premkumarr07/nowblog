part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class FetchUserTodosEvent extends TodoEvent {
  final int userId;

  const FetchUserTodosEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class RefreshUserTodosEvent extends TodoEvent {
  final int userId;

  const RefreshUserTodosEvent(this.userId);

  @override
  List<Object> get props => [userId];
}