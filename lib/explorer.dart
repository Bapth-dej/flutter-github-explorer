import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles/styles.dart';
import 'package:http/http.dart' as http;

import './profile_info.dart';

class Explorer extends StatefulWidget {
  final String title;
  Explorer({Key key, this.title}) : super(key: key);

  @override
  _ExplorerState createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  final nameInputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    nameInputController.addListener(_onNameInputChanged);
  }

  @override
  void dispose() {
    nameInputController.dispose();
    super.dispose();
  }

  void _onNameInputChanged() {
    print("Second text field: ${nameInputController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: Styles.navBarTitle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: nameInputController,
          ),
          ProfileInfo(
            userName: "Bapth-dej",
            bio: "Web developper React | Elm",
            imageUrl:
                "https://avatars3.githubusercontent.com/u/45099063?s=460&v=4",
          ),
        ],
      ),
    );
  }
}
