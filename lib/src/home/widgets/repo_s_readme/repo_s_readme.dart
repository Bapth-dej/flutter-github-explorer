import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../models/repo_model.dart';

class ReposReadme extends StatelessWidget {
  final String readmeText;
  final RepoModel repo;
  ReposReadme({@required this.readmeText, @required this.repo});

  @override
  Widget build(BuildContext context) {
    return

        //Column(
        //children: <Widget>[
        //Text(
        //repo.name,
        //style: Styles.headerLarge,
        //),
        Markdown(data: readmeText) //,
        //SingleChildScrollView(child: Text(readmeText)),
        //],)
        ;
  }
}
