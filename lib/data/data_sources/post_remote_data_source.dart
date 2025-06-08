// data/data_sources/post_remote_data_source.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/exceptions.dart';
import '../../domain/entities/post.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<Post>> getUserPosts(int userId);
  Future<Post> createPost(String title, String body, int userId);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Post>> getUserPosts(int userId) async {
    final response = await client.get(
      Uri.parse('https://dummyjson.com/posts/user/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data.containsKey('posts')) {
        final postsList = data['posts'] as List;
        return postsList.map((postJson) => PostModel.fromJson(postJson)).toList();
      } else {
        throw ServerException('Failed to load posts');
      }
    } else {
      throw ServerException('Failed to load posts');
    }
  }

  @override
  Future<Post> createPost(String title, String body, int userId) async {
    final response = await client.post(
      Uri.parse('https://dummyjson.com/posts/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'body': body,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return PostModel.fromJson(data);
    } else {
      throw ServerException('Failed to create post');
    }
  }
}
