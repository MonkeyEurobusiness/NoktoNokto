class User {
  final int id;
  final String email;
  final String username;

  User(this.id, this.email, this.username);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['email'] as String,
      json['username'] as String,
    );
  }
}
