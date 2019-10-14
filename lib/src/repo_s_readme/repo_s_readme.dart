import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles.dart';

class ReposReadme extends StatelessWidget {
  final String readmeText;
  final String repoName;
  ReposReadme(this.repoName, this.readmeText);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.repoName,
          style: Styles.navBarTitle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(child: Text(readmeText)),
        ],
      ),
    );
  }
}
