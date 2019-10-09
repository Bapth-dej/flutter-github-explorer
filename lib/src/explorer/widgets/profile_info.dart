import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles.dart';

class ProfileInfo extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String bio;

  ProfileInfo({this.userName, this.bio, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.network(
          this.imageUrl,
          fit: BoxFit.fitWidth,
        ),
        Text(
          this.userName,
          style: Styles.headerLarge,
        ),
        Text(
          this.bio,
          style: Styles.textDefault,
        )
      ],
    );
  }
}
