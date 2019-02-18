import 'dart:io';

import 'package:flutter/material.dart';


//ignore: must_be_immutable
class IndexDrawPage extends StatelessWidget {
  String name, profileImage, email, background;

  IndexDrawPage({this.name, this.profileImage, this.email, this.background});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: new Text(name),
          accountEmail: new Text(email),
          currentAccountPicture:
              new CircleAvatar(backgroundImage: new AssetImage(profileImage)),
          decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new AssetImage(background), fit: BoxFit.cover)),
        ),
        new ListTile(
          title: new Text("退出"),
          trailing: new Icon(
            Icons.exit_to_app,
            color: Colors.green,
          ),
          onTap: () {
            print("退出");
            Navigator.of(context).pop();
            //退出APP
            exit(0);
          },
        )
      ],
    );
  }
}
