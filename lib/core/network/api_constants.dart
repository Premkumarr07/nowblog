class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com';

  static const String users = '/users';
  static const String userPosts = '/posts/user';
  static const String userTodos = '/todos/user';
  static const String posts = '/posts/add';

  static String getUsers({int limit = 10, int skip = 0}) =>
      '$users?limit=$limit&skip=$skip';

  static String searchUsers(String query) => '$users/search?q=$query';

  static String getUserPosts(int userId) => '$userPosts/$userId';

  static String getUserTodos(int userId) => '$userTodos/$userId';
}
