class User {
  final String id;
  final String email;
  final String password;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.username,
  });

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      username: map['username'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }
}
