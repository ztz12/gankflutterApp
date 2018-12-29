import 'package:flutter/material.dart';
import 'package:gankflutter/model/MenuModel.dart';

class CommonShare {
  static buildShowBottomPop(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 120.0,
            color: Colors.white,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              padding: EdgeInsets.all(4.0),
              children: menus_share.map((Menu m) {
                return new GestureDetector(
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => new AlertDialog(
                            title: new Text("other way to,login"),
                            content: new Text(m.title),
                          )),
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: new Image.asset(
                            m.icon,
                            width: 40.0,
                            height: 40.0,
                          )),
                      new Text(m.title)
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        });
  }
}
