import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/repos_change_notifier.dart';
import 'package:flutter_github_explorer/src/list_repos/models/repo_model.dart';
import 'package:flutter_github_explorer/styles.dart';
import 'package:flutter_github_explorer/order_list_by.dart';
import 'package:provider/provider.dart';

class ListRepos extends StatelessWidget {
  final String username;
  ListRepos(this.username);

  List<RepoModel> _getListOfReposOrderedBy(
      List<Map<String, dynamic>> jsonListOfrepos, OrderListBy orderListBy) {
    switch (orderListBy) {
      case OrderListBy.date:
        jsonListOfrepos
            .sort((a, b) => -(a['created_at']).compareTo(b['created_at']));
        break;
      case OrderListBy.alphabetical:
        jsonListOfrepos.sort((a, b) =>
            (a['name'].toLowerCase()).compareTo(b['name'].toLowerCase()));
        break;
      case OrderListBy.language:
        jsonListOfrepos
            .sort((a, b) => (a['language']).compareTo(b['language']));
        break;
    }
    List<RepoModel> listOfRepos = [];
    for (var jsonRepo in jsonListOfrepos) {
      listOfRepos.add(RepoModel.fromJson(jsonRepo));
    }
    return listOfRepos;
  }

  String _getDropDownMenuItemString(OrderListBy itemChoosen) {
    switch (itemChoosen) {
      case OrderListBy.date:
        return "Date";
      case OrderListBy.alphabetical:
        return "Alphabetical";
      case OrderListBy.language:
        return "Language used";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<RepoModel> listOfRepos = _getListOfReposOrderedBy(
      Provider.of<Repos>(context).jsonListOfrepos,
      Provider.of<Repos>(context).orderListBy,
    );

    var _orderListByItems = [
      OrderListBy.date,
      OrderListBy.alphabetical,
      OrderListBy.language,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("$username's repos"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Order list by: "),
              DropdownButton<OrderListBy>(
                items: _orderListByItems.map((OrderListBy orderlistBy) {
                  return DropdownMenuItem<OrderListBy>(
                    value: orderlistBy,
                    child: Text(_getDropDownMenuItemString(orderlistBy)),
                  );
                }).toList(),
                onChanged: (OrderListBy orderListBy) {
                  Provider.of<Repos>(context, listen: false)
                      .updateOrderListBy(orderListBy);
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listOfRepos.length,
              itemBuilder: (context, index) {
                final _currRepo = listOfRepos[index];
                return Card(
                  elevation: 8.0,
                  child: Column(
                    children: <Widget>[
                      Text(
                        _currRepo.name,
                        style: Styles.headerLarge,
                      ),
                      Text(
                        _currRepo.description,
                        style: Styles.textDefault,
                      ),
                      Text("Created: ${_currRepo.createdAt.toString()}"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
