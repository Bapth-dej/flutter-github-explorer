import 'package:flutter/material.dart';
import 'package:flutter_github_explorer/styles.dart';

class ProfileInfo extends StatelessWidget {
  final String imageUrl;
  final String userName;
  final String bio;

  ProfileInfo({
    this.userName,
    this.bio,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Image.network(
              this.imageUrl,
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            Flexible(
              child: Text(
                this.userName,
                style: Styles.headerLarge,
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            this.bio,
            style: Styles.textDefault,
          ),
        ),
      ],
    );
  }
}
