import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/todo.dart';
import '../repositories/user_repository.dart';


class GetUserTodos {
  final UserRepository repository;

  GetUserTodos(this.repository);

  Future<Either<Failure, List<Todo>>> execute(int userId) {
    return repository.getUserTodos(userId);
  }
}
