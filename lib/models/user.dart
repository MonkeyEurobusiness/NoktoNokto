class User {
  final int id;
  final String email;
  final String username;
  final String profilePicture;

  User(this.id, this.email, this.username, this.profilePicture);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['email'] as String,
      json['username'] as String,
      json['profilePicture'] as String,
    );
  }
}
