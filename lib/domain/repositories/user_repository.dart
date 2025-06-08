import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../entities/post.dart';
import '../entities/todo.dart';
import '../entities/user.dart';


abstract class UserRepository {
  Future<Either<Failure, List<User>>> fetchUsers({int limit = 10, int skip = 0});
  Future<Either<Failure, List<User>>> searchUsers(String query);
  Future<Either<Failure, List<Post>>> getUserPosts(int userId);
  Future<Either<Failure, List<Todo>>> getUserTodos(int userId);
  Future<Either<Failure, Post>> createPost(String title, String body, int userId);
}