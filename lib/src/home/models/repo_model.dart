import 'package:json_annotation/json_annotation.dart';

part 'repo_model.g.dart';

@JsonSerializable(nullable: false)
class RepoModel {
  final String name;
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  final String language;

  RepoModel(this.name, String description, this.createdAt, String language)
      : description = description ?? "No description provided.",
        language = language ?? "No language specified";

  factory RepoModel.fromJson(Map<String, dynamic> json) =>
      _$RepoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepoModelToJson(this);

  /*factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      json['name'],
      json['description'] ?? "No description provided.",
      DateTime.parse(json['created_at']),
      json['language'] ?? "No language specified",
    );
  }*/
}
