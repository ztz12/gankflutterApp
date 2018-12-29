import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gankflutter/utils/ToastUtils.dart';

/// 网页展示界面
class WebViewPage extends StatefulWidget {
  final Map<String, dynamic> post;

  WebViewPage(this.post);

  @override
  State<StatefulWidget> createState() => new _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  
  bool isLoaded = false;

  // Instance of WebView plugin
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  StreamSubscription<WebViewStateChanged> _onStateChanged;

  bool loading = false;

  @override
  initState() {
    super.initState();

    flutterWebViewPlugin.close();

    _onStateChanged =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print("state: ${state.type}");
      if (state.type == WebViewState.finishLoad) {
        // 加载完成
        setState(() {
          isLoaded = true;
        });
      }
    });
  }

  _showToast(String msg,BuildContext context){
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(msg),action: new SnackBarAction(label: "提示", onPressed: null),));
  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.

    _onStateChanged.cancel();
    flutterWebViewPlugin.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.post['url']);
    String title =
        widget.post['desc'] == null ? '一个陌生的地方' : widget.post['desc'];

    List<Widget> titleContent = [];
    if (!isLoaded) {
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Expanded(
        child: new Text(title,
            overflow: TextOverflow.ellipsis,
            style: new TextStyle(fontSize: 16.0))));

    return new WebviewScaffold(
      url: widget.post['url'],
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        //title: new Text(title),
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
//                ToastUtils.showToast("refresh");
              _showToast("refresh", context);
              },
            ),
          ),
          new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new IconButton(
              icon: new Icon(Icons.share),
              onPressed: () {
                _showToast("share", context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
