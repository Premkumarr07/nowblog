class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  // add other fields as per your API

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    // other fields
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      // parse other fields
    );
  }
}
