import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import './widgets/profile_info.dart';
import '../list_repos/list_repos.dart';
import '../../models/repo_model.dart';
import '../../models/user.dart';
import '../../providers/repos_change_notifier.dart';

class Explorer extends StatefulWidget {
  final navigateToReposList;

  Explorer({this.navigateToReposList});

  @override
  _Explorer createState() => _Explorer();
}

class _Explorer extends State<Explorer> {
  final nameInputController = TextEditingController();

  String _name = "";
  bool _clickable = false;
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

  void handleFetch() {
    setState(() {
      _user = null;
      _clickable = false;
    });
    fetchUser();
    fetchRepos();
  }

  void fetchUser() async {
    print("fetching user");
    final response = await http.get("https://api.github.com/users/$_name");
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['login'] != null) {
        User user = User.fromJson(jsonResponse);
        setState(() {
          _user = user;
        });
      }
    } else {
      // If that response was not OK
      setState(() {
        _user = null;
      });
    }
    print("done fetching user");
  }

  void fetchRepos() async {
    print("fetching repos");
    final response =
        await http.get("https://api.github.com/users/$_name/repos");
    if (response.statusCode == 200) {
      List<RepoModel> listOfRepos = [];
      List<Map<String, dynamic>> listOfMapRepos = [];
      List<dynamic> jsonListOfrepos = json.decode(response.body);
      for (var jsonRepo in jsonListOfrepos) {
        if (jsonRepo is Map<String, dynamic>) {
          listOfMapRepos.add(jsonRepo);
          print("ok ${jsonRepo['name']}");
        } else
          print("ko $jsonRepo");
      }
      for (var jsonRepo in jsonListOfrepos) {
        listOfRepos.add(RepoModel.fromJson(jsonRepo));
      }
      setState(() {
        _clickable = true;
      });
      Provider.of<Repos>(context, listen: false)
          .updateCurrentSearchedUserListOfRepos(listOfRepos);
    }
    print("done fetching repos");
  }

  void _onNameInputChanged() {
    print("Second text field: ${nameInputController.text}");
    setState(() {
      _name = nameInputController.text;
    });
  }

  void _navigateToReposList() {
    if (_clickable) widget.navigateToReposList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextField(
          autocorrect: false,
          autofocus: true,
          controller: nameInputController,
          cursorColor: Colors.deepOrangeAccent,
          onEditingComplete: fetchUser,
        ),
        RaisedButton(
          onPressed: () => handleFetch(),
          child: Text('Fetch user'),
        ),
        _user != null
            ? Card(
                elevation: 8.0,
                child: InkWell(
                    splashColor: Colors.deepOrange,
                    onTap: _navigateToReposList,
                    child: ProfileInfo(
                      userName: _user.name,
                      bio: _user.bio,
                      imageUrl: _user.avatarUrl,
                    )))
            : null,
      ].where((t) => t != null).toList(),
    );
  }
}
