import 'package:flutter/material.dart';

class ToastUtils{
  static GlobalKey<ScaffoldState> scaffoldKey;
  static showToast(String msg){
    if(scaffoldKey==null){
      scaffoldKey = new GlobalKey<ScaffoldState>();
    }
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(msg)));
  }
}