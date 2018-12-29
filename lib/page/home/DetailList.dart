import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gankflutter/utils/TimeUtils.dart';
import 'package:gankflutter/model/DailyResponse.dart';
import 'package:gankflutter/constant/GoldenConfig.dart';
import 'package:gankflutter/utils/PageRouteUtils.dart';
import 'package:gankflutter/page/WebViewPage.dart';

Widget buildDetailListRow(context, PostData postData) {
  return new InkWell(
      onTap: () {
      routePageNavigator(context, new WebViewPage(postData.toJson()));
      },
      child: new Card(
        margin: new EdgeInsets.all(2.0),
        child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Row(children: [
                new Container(
                  margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Icon(
                      Icons.access_time,
                      size: 12.0,
                      color: GoldenConfig.colorPrimary,
                    ),
                  ),
                ),
                new Text(
                  postData.publishedAt.toString(),
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                new Expanded(
                    child: new Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    getTimestampString(DateTime.parse(postData.publishedAt)),
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )),
              ]),
              new Container(
                margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 14.0),
                child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    postData.desc,
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              new Row(children: [
                new Text(
                  '作者:',
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                new Text(
                  postData.who.toString(),
                  style: new TextStyle(
                      fontSize: 12.0, color: GoldenConfig.colorPrimary),
                ),
                new Expanded(
                    child: new Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    postData.source.toString(),
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )),
              ]),
            ],
          ),
        ),
      ));
}
