import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';


import '../entities/post.dart';
import '../repositories/user_repository.dart';

class GetUserPosts {
  final UserRepository repository;

  GetUserPosts(this.repository);

  Future<Either<Failure, List<Post>>> execute(int userId) async {
    return await repository.getUserPosts(userId);
  }
}