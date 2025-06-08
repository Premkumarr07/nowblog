import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/todo.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel extends Todo {
  TodoModel({
    required int id,
    required String todo,
    required bool completed,
    required int userId,
  }) : super(
    id: id,
    todo: todo,
    completed: completed,
    userId: userId,
  );

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
