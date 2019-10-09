class User {
  final String avatarUrl;
  final String name;
  final String bio;

  User({this.avatarUrl, this.bio, this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        avatarUrl: json['avatar_url'] ?? "",
        name: json['name'] ?? json['login'],
        bio: json['bio'] ?? "");
  }

  String getAvatarUrl() => this.avatarUrl;
  String getName() => this.name;
  String getBio() => this.bio;
}
