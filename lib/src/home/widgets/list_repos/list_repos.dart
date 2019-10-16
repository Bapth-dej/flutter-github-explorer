import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/src/home/widgets/repo_s_readme/repo_s_readme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_github_explorer/styles.dart';
import '../../models/order_list_by.dart';
import 'package:provider/provider.dart';

import '../../providers/repos_change_notifier.dart';
import '../../models/repo_model.dart';
import '../../models/user.dart';

class ListRepos extends StatelessWidget {
  final navigateToExplorer;

  ListRepos({this.navigateToExplorer});

  List<RepoModel> _getListOfReposOrderedBy(
      List<RepoModel> originalListOfRepos, OrderListBy orderListBy) {
    List<RepoModel> listOfRepos = originalListOfRepos;
    switch (orderListBy) {
      case OrderListBy.date:
        listOfRepos.sort((a, b) => -(a.createdAt).compareTo(b.createdAt));
        break;
      case OrderListBy.alphabetical:
        listOfRepos.sort(
            (a, b) => (a.name.toLowerCase()).compareTo(b.name.toLowerCase()));
        break;
      case OrderListBy.language:
        listOfRepos.sort((a, b) => (a.language).compareTo(b.language));
        break;
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

  void _handleRepoTap(
      BuildContext context, int index, User user, RepoModel repo) async {
    print("Fetching ${user.username}, ${repo.name}");
    // If server returns an OK response, parse the JSON.
    String textResponse, errorMessage;
    try {
      final response = await http.get(
          "https://api.github.com/repos/${user.username}/${repo.name}/readme");
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse;
        const base64 = Base64Decoder();
        const utf8 = Utf8Codec();

        try {
          jsonResponse = json.decode(response.body);
        } catch (error) {
          errorMessage =
              "The server returned an unexpected response. Please try again later.";
        }

        if (jsonResponse['content'] == null) {
          errorMessage =
              "The server returned an unexpected response. Please try again later.";
        } else {
          var content =
              jsonResponse['content'].replaceAll(new RegExp(r'\n'), '');
          var decodedresponse = base64.convert(content);
          textResponse = utf8.decode(decodedresponse);
        }
      } else if (response.statusCode == 404) {
        errorMessage = "This repo doesn\'t provide a README file.";
      } else {
        errorMessage =
            "Server answered with an error, please wait while we try to fix the problem.";
      }
    } catch (error) {
      errorMessage =
          "The server is unavailable. Please check your connexion or try again later.";
      print(error.toString());
    }
    if (textResponse != null) {
      showModalBottomSheet(
        context: context,
        builder: (_) => ReposReadme(readmeText: textResponse, repo: repo),
      );
    } else if (errorMessage != null) {
      final wrongReadmeAPIResponseSnackBar = SnackBar(
        content: Text(errorMessage),
      );
      Scaffold.of(context).showSnackBar(wrongReadmeAPIResponseSnackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<RepoModel> listOfRepos = _getListOfReposOrderedBy(
      Provider.of<Repos>(context).currentSearchedUserListOfRepos,
      Provider.of<Repos>(context).orderListBy,
    );

    final user = Provider.of<Repos>(context).currentSearchedUser;

    var _orderListByItems = [
      OrderListBy.date,
      OrderListBy.alphabetical,
      OrderListBy.language,
    ];

    return WillPopScope(
      onWillPop: () async {
        navigateToExplorer();
        return false;
      },
      child: Column(
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
                  child: InkWell(
                    onTap: () => _handleRepoTap(
                      context,
                      index,
                      user,
                      _currRepo,
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          _currRepo.name,
                          style: Styles.headerLarge,
                        ),
                        Text(
                          "(${_currRepo.language})",
                          style: Styles.textDefault,
                        ),
                        Text(
                          _currRepo.description,
                          style: Styles.textDefault,
                        ),
                        Text("Created: ${_currRepo.createdAt.toString()}"),
                      ],
                    ),
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
