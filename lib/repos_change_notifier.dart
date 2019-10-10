import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/src/list_repos/models/list_repos_model.dart';

class Repos with ChangeNotifier {
  ListReposModel listOfRepos;

  void updateListRepos(ListReposModel _listOfRepos) {
    this.listOfRepos = _listOfRepos;
    notifyListeners();
  }
}
