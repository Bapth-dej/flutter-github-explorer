import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import './widgets/profile_info.dart';
import './models/user.dart';

class Explorer extends StatefulWidget {
  final String title;
  Explorer({Key key, this.title}) : super(key: key);

  @override
  _Explorer createState() => _Explorer();
}

class _Explorer extends State<Explorer> {
  final nameInputController = TextEditingController();

  String _name;
  User _user;

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

  void fetchUser(username) async {
    final response = await http.get("https://api.github.com/users/$username");
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      User user = User.fromJson(json.decode(response.body));
      setState(() {
        _user = user;
      });
    } else {
      // If that response was not OK
    }
  }

  void _onNameInputChanged() {
    print("Second text field: ${nameInputController.text}");
    setState(() {
      _name = nameInputController.text;
    });
    fetchUser(nameInputController.text);
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
          _user != null
              ? ProfileInfo(
                  userName: _user.getName(),
                  bio: _user.getBio(),
                  imageUrl: _user.getAvatarUrl(),
                )
              : null,
        ].where((t) => t != null).toList(),
      ),
    );
  }
}
