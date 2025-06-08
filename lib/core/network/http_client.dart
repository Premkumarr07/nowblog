import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../error/exceptions.dart';

class HttpClient {
  final http.Client client;

  HttpClient({required this.client});

  Future<dynamic> get(String url) async {
    try {
      final response = await client.get(Uri.parse(url));

      return _handleResponse(response);
    } on SocketException {
      throw ServerException('No Internet connection');
    } on HttpException {
      throw ServerException('Could not reach the server');
    } on FormatException {
      throw ServerException('Bad response format');
    }
  }

  Future<dynamic> post(String url, {required Map<String, dynamic> body}) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      return _handleResponse(response);
    } on SocketException {
      throw ServerException('No Internet connection');
    } on HttpException {
      throw ServerException('Could not reach the server');
    } on FormatException {
      throw ServerException('Bad response format');
    }
  }

  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw ServerException('Bad request');
      case 401:
      case 403:
        throw ServerException('Unauthorized');
      case 404:
        throw ServerException('Not found');
      case 500:
        throw ServerException('Internal server error');
      default:
        throw ServerException('Something went wrong');
    }
  }
}