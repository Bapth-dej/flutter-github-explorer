import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_github_explorer/styles.dart';

import '../../models/repo_model.dart';
import '../../providers/repos_change_notifier.dart';

class ReposReadme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RepoModel repo = Provider.of<Repos>(context).currentSearchedRepo;
    String readmeText = Provider.of<Repos>(context).currentSeacrchedRepoReadme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          repo.name,
          style: Styles.navBarTitle,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(child: Text(readmeText)),
          ),
        ],
      ),
    );
  }
}
