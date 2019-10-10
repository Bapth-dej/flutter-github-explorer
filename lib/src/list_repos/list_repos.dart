import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/repos_change_notifier.dart';
import 'package:provider/provider.dart';

class ListRepos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bapth-dej's repos"),
        ),
        body: Consumer<Repos>(
          builder: (context, repos, child) => ListView.builder(
            itemCount: repos.listOfRepos.length(),
            itemBuilder: _listOfReposItemBuilder,
          ),
        ));
  }

  Widget _listOfReposItemBuilder(BuildContext context, int index) {
    var Repo = 0;
  }
}
