import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(nullable: false)
class User {
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  final String name;
  final String username;
  final String bio;

  User(String avatarUrl, String bio, String name, this.username)
      : avatarUrl = avatarUrl ?? "",
        name = name ?? username,
        bio = bio ?? "";

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
