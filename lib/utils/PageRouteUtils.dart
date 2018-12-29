import 'package:flutter/material.dart';

routePageNavigator(BuildContext context, Widget v) {
  Navigator.of(context).push(new PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, _, __) {
        return v;
      },
      transitionsBuilder:
          (context, Animation<double> animation, _, Widget child) {
        return new FadeTransition(
          opacity: animation,
          child: new FadeTransition(
            opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: child,
          ),
        );
      })
  );
}

