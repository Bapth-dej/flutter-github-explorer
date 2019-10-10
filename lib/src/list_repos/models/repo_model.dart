class RepoModel {
  final String name;
  final String description;
  final DateTime createdAt;

  RepoModel({this.name, this.description, this.createdAt});

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
