class User {
  final String avatarUrl;
  final String name;
  final String username;
  final String bio;

  User({this.avatarUrl, this.bio, this.name, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      avatarUrl: json['avatar_url'] ?? "",
      name: json['name'] ?? json['login'],
      username: json['login'],
      bio: json['bio'] ?? "",
    );
  }
}
