class RepoModel {
  final String name;
  final String description;
  final DateTime createdAt;
  final String language;

  RepoModel({this.name, this.description, this.createdAt, this.language});

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'],
      description: json['description'] ?? "No description provided.",
      createdAt: DateTime.parse(json['created_at']),
      language: json['language'] ?? "No language specified",
    );
  }
}
