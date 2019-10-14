import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/order_list_by.dart';
import 'package:flutter_github_explorer/src/list_repos/models/repo_model.dart';

class Repos with ChangeNotifier {
  List<RepoModel> listOfRepos;
  List<Map<String, dynamic>> jsonListOfrepos;
  OrderListBy orderListBy;

  void updateListRepos(List<RepoModel> _listOfRepos) {
    this.listOfRepos = _listOfRepos;
    notifyListeners();
  }

  void updateJsonListRepos(List<Map<String, dynamic>> _jsonListOfrepos) {
    this.jsonListOfrepos = _jsonListOfrepos;
    notifyListeners();
  }

  void updateOrderListBy(OrderListBy _orderListBy) {
    this.orderListBy = _orderListBy;
    notifyListeners();
  }
}
