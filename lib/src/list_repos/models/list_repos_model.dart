import './repo_model.dart';

class ListReposModel {
  final List<RepoModel> listofrepos;

  ListReposModel({
    this.listofrepos,
  });

  factory ListReposModel.fromJson(List<dynamic> json) {
    List<RepoModel> repoList = [];
    for (var jsonRepo in json) {
      repoList.add(RepoModel.fromJson(jsonRepo));
    }
    return ListReposModel(listofrepos: repoList);
  }

  int length() => listofrepos.length;
}
