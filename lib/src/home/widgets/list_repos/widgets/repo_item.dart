import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles.dart';

import '../../../models/repo_model.dart';

class RepoItem extends StatelessWidget {
  final RepoModel repo;
  final handleRepoTap;
  RepoItem({@required this.repo, @required this.handleRepoTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      child: InkWell(
        onTap: handleRepoTap,
        child: Column(
          children: <Widget>[
            Text(
              repo.name,
              style: Styles.headerLarge,
            ),
            Text(
              "(${repo.language})",
              style: Styles.textDefault,
            ),
            Text(
              repo.description,
              style: Styles.textDefault,
            ),
            Text("Created: ${repo.createdAt.toString()}"),
          ],
        ),
      ),
    );
  }
}
