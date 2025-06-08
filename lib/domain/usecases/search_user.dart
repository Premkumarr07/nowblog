// lib/domain/usecases/search_users.dart

import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../../core/error/failure.dart';

class SearchUsers {
  final UserRepository repository;

  SearchUsers(this.repository);

  Future<Either<Failure, List<User>>> call(String query) {
    return repository.searchUsers(query);
  }
}
