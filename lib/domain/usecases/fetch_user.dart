// lib/domain/usecases/fetch_users.dart

import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../../core/error/failure.dart';

class FetchUser {
  final UserRepository repository;

  FetchUser(this.repository);

  Future<Either<Failure, List<User>>> call({required int limit, required int skip}) {
    return repository.fetchUsers(limit: limit, skip: skip);
  }
}
