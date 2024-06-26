class User {
  final String token;

  User({
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(token: data['token']);
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}
