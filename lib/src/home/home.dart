import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/src/home/widgets/list_repos/list_repos.dart';
import 'package:provider/provider.dart';
import 'package:flutter_github_explorer/styles.dart';

import './providers/repos_change_notifier.dart';
import './widgets/explorer/explorer.dart';

enum HomeDisplayState { explorer, listRepo, repoSReadme }

class Home extends StatefulWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  HomeDisplayState homeDisplayState = HomeDisplayState.explorer;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Repos(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: Styles.navBarTitle,
          ),
        ),
        body: homeDisplayState == HomeDisplayState.explorer
            ? Explorer(
                navigateToReposList: () => setState(() {
                  homeDisplayState = HomeDisplayState.listRepo;
                }),
              )
            : ListRepos(
                navigateToExplorer: () => setState(() {
                  homeDisplayState = HomeDisplayState.explorer;
                }),
              ),
      ),
    );
  }
}
