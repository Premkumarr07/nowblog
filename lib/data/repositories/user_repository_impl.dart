import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/post_remote_data_source.dart';
import '../data_sources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final PostRemoteDataSource postRemoteDataSource;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.postRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> fetchUsers({int limit = 10, int skip = 0}) async {
    try {
      final users = await userRemoteDataSource.fetchUsers(limit: limit, skip: skip);
      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<User>>> searchUsers(String query) async {
    try {
      final users = await userRemoteDataSource.searchUsers(query);
      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getUserPosts(int userId) async {
    try {
      final posts = await postRemoteDataSource.getUserPosts(userId);
      return Right(posts);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Post>> createPost(String title, String body, int userId) async {
    try {
      final post = await postRemoteDataSource.createPost(title, body, userId);
      return Right(post);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getUserTodos(int userId) async {
    try {
      final todos = await userRemoteDataSource.getUserTodos(userId);
      return Right(todos);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
