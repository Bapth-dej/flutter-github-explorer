import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import './widgets/profile_info.dart';
import '../../models/repo_model.dart';
import '../../models/user.dart';
import '../../providers/repos_change_notifier.dart';

class Explorer extends StatefulWidget {
  final navigateToReposList;
  Explorer({@required this.navigateToReposList});

  @override
  _Explorer createState() => _Explorer();
}

class _Explorer extends State<Explorer> {
  final nameInputController = TextEditingController();

  String _name = "";
  bool _clickable = false;

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
      _clickable = false;
    });
    _fetchUser();
  }

  void _fetchUser() async {
    User user;
    String errorMessage;
    //the http.get throws an error if it doesn't get an answer
    try {
      final response = await http.get("https://api.github.com/users/$_name");
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        //We check if it has the correct shape
        Map<String, dynamic> jsonResponse;
        try {
          jsonResponse = json.decode(response.body);
        } catch (error) {
          errorMessage =
              "The server returned an unexpected response. Please try again later.";
        }

        //We check that the login field exists
        if (jsonResponse['login'] == null) {
          errorMessage =
              "The server returned an unexpected response. Please try again later.";
        } else {
          user = User.fromJson(jsonResponse);
        }
      } else if (response.statusCode == 404) {
        errorMessage = "User not found, please check the username.";
      } else if (response.statusCode == 403) {
        errorMessage =
            "You made too many requests, please wait and try again later.";
      } else {
        //If the server returns an error
        errorMessage =
            "${response.statusCode} Server answered with an error, please wait while we try to fix the problem.";
      }
    } catch (error) {
      errorMessage =
          "The server is unavailable. Please check your connexion or try again later.";
    }

    Provider.of<Repos>(context).updateCurrentSearchedUser(user);
    if (errorMessage != null) {
      final wrongReadmeAPIResponseSnackBar = SnackBar(
        content: Text(errorMessage),
      );
      Scaffold.of(context).showSnackBar(wrongReadmeAPIResponseSnackBar);
    } else {
      setState(() {
        _clickable = true;
      });
    }
  }

  Future<bool> _fetchRepos() async {
    List<RepoModel> listOfRepos = [];
    String errorMessage;
    try {
      final response =
          await http.get("https://api.github.com/users/$_name/repos");
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        //We check if it has the correct shape
        List<dynamic> jsonListOfrepos;
        try {
          jsonListOfrepos = json.decode(response.body);
        } catch (error) {
          errorMessage =
              "The server returned an unexpected response. Please try again later.";
        }

        //json.decode returns a List<dynamic> when we want a List<Map<String, dynamic>>
        //we only keep elements of the list that are ok and parse it to RepoModel class
        for (var jsonRepo in jsonListOfrepos) {
          if (jsonRepo is Map<String, dynamic> && jsonRepo['name'] != null) {
            listOfRepos.add(RepoModel.fromJson(jsonRepo));
          }
        }

        //If the list is empty, then the response si not what we expected
        if (listOfRepos.isEmpty) {
          errorMessage =
              "The server returned an unexpected response. Please try again later.";
        }
      } else if (response.statusCode == 404) {
        errorMessage = "User's repos not found, please check the username.";
      } else if (response.statusCode == 403) {
        errorMessage =
            "You made too many requests, please wait and try again later.";
      } else {
        //If the server returns an error
        errorMessage =
            "Server answered with an error, please wait while we try to fix the problem.";
      }
    } catch (error) {
      errorMessage =
          "The server is unavailable. Please check your connexion or try again later.";
    }
    if (listOfRepos != []) {
      Provider.of<Repos>(context, listen: false)
          .updateCurrentSearchedUserListOfRepos(listOfRepos);
    }
    if (errorMessage != null) {
      final wrongReadmeAPIResponseSnackBar = SnackBar(
        content: Text(errorMessage),
      );
      Scaffold.of(context).showSnackBar(wrongReadmeAPIResponseSnackBar);
    }

    return !(listOfRepos == [] || errorMessage != null);
  }

  void _onNameInputChanged() {
    setState(() {
      _name = nameInputController.text;
    });
  }

  void _navigateToReposList() async {
    if (_clickable) {
      bool shouldNavigate = await _fetchRepos();
      if (shouldNavigate) {
        setState(() {
          _clickable = false;
        });
        widget.navigateToReposList();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<Repos>(context).currentSearchedUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        TextField(
          autocorrect: false,
          autofocus: true,
          controller: nameInputController,
          cursorColor: Colors.deepOrangeAccent,
          decoration: InputDecoration(labelText: 'Search username on Github'),
          onEditingComplete: _fetchUser,
        ),
        RaisedButton(
          onPressed: () => handleFetch(),
          child: Text('Fetch user'),
        ),
        user != null
            ? Card(
                elevation: 8.0,
                child: InkWell(
                    splashColor: Colors.deepOrange,
                    onTap: () => _navigateToReposList(),
                    child: ProfileInfo(
                      userName: user.name,
                      bio: user.bio,
                      imageUrl: user.avatarUrl,
                    )))
            : null,
      ].where((t) => t != null).toList(),
    );
  }
}
