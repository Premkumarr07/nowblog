// data/data_sources/user_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/user.dart';
import '../../domain/entities/todo.dart';
import '../../core/error/exceptions.dart';
import '../models/todo_model.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> fetchUsers({int limit = 10, int skip = 0});
  Future<List<User>> searchUsers(String query);
  Future<List<Todo>> getUserTodos(int userId);
  Future<User> updateUser(int id, Map<String, dynamic> updatedData);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<User>> fetchUsers({int limit = 10, int skip = 0}) async {
    final response = await client.get(
      Uri.parse('https://dummyjson.com/users?limit=$limit&skip=$skip'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final usersJson = data['users'] as List;
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to fetch users');
    }
  }

  @override
  Future<List<User>> searchUsers(String query) async {
    final response = await client.get(
      Uri.parse('https://dummyjson.com/users/search?q=$query'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final usersJson = data['users'] as List;
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to search users');
    }
  }

  @override
  Future<List<Todo>> getUserTodos(int userId) async {
    final response = await client.get(
      Uri.parse('https://dummyjson.com/users/$userId/todos'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final todosJson = data['todos'] as List;
      return todosJson.map((json) => TodoModel.fromJson(json)).toList();
    } else {
      throw ServerException('Failed to fetch todos');
    }
  }

  @override
  Future<User> updateUser(int id, Map<String, dynamic> updatedData) async {
    final response = await client.put(
      Uri.parse('https://dummyjson.com/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw ServerException('Failed to update user');
    }
  }
}
