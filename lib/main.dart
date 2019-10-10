import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/explorer.dart';
import 'package:flutter_github_explorer/repos_change_notifier.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
      builder: (context) => Repos(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Explorer(title: 'GitHub Explorer'),
    );
  }
}
