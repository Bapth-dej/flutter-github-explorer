import 'package:flutter/material.dart';

import '../models/order_list_by.dart';
import '../models/repo_model.dart';
import '../models/user.dart';

class Repos with ChangeNotifier {
  User currentSearchedUser;
  List<RepoModel> currentSearchedUserListOfRepos;
  RepoModel currentSearchedRepo;
  String currentSearchedRepoReadme;
  OrderListBy orderListBy;

  void updateCurrentSearchedUser(User _user) {
    this.currentSearchedUser = _user;
    notifyListeners();
  }

  void updateCurrentSearchedUserListOfRepos(List<RepoModel> _listOfRepos) {
    this.currentSearchedUserListOfRepos = _listOfRepos;
    notifyListeners();
  }

  void updateOrderListBy(OrderListBy _orderListBy) {
    this.orderListBy = _orderListBy;
    notifyListeners();
  }

  void updateCurrentSearchedRepo(RepoModel _repo) {
    this.currentSearchedRepo = _repo;
  }

  void updateCurrentSearchedRepoReadme(String _repoReadme) {
    this.currentSearchedRepoReadme = _repoReadme;
  }
}
