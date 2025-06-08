import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/todo.dart';
import '../../../domain/usecases/get_user_todos.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetUserTodos getUserTodos;

  TodoBloc({required this.getUserTodos}) : super(TodoInitial()) {
    on<FetchUserTodosEvent>(_onFetchUserTodos);
    on<RefreshUserTodosEvent>(_onRefreshUserTodos);
  }

  Future<void> _onFetchUserTodos(
      FetchUserTodosEvent event,
      Emitter<TodoState> emit,
      ) async {
    if (state is TodoLoading) return;

    emit(TodoLoading());
    try {
      final result = await getUserTodos.execute(event.userId);
      result.fold(
            (failure) => emit(TodoError(failure.message)),
            (todos) => emit(TodoLoaded(todos)),
      );
    } catch (e) {
      emit(TodoError('Failed to fetch todos'));
    }
  }

  Future<void> _onRefreshUserTodos(
      RefreshUserTodosEvent event,
      Emitter<TodoState> emit,
      ) async {
    emit(TodoLoading());
    try {
      final result = await getUserTodos.execute(event.userId);
      result.fold(
            (failure) => emit(TodoError(failure.message)),
            (todos) => emit(TodoLoaded(todos)),
      );
    } catch (e) {
      emit(TodoError('Failed to refresh todos'));
    }
  }
}