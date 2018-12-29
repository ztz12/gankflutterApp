import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:gankflutter/constant/GoldenConfig.dart';
import 'package:gankflutter/model/LoginModel.dart';
import 'package:gankflutter/page/settingCard.dart';
import 'package:gankflutter/api/Http.dart';
import 'package:gankflutter/utils/PageRouteUtils.dart';
import 'package:gankflutter/utils/CommonShare.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> with HttpExt {

  String _username = '';

  String _password = '';

  Widget _buildUsernameEdit() {
    var node = new FocusNode();
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: new TextField(
        onChanged: (str) {
          _username = str;
          //use setState to change textField input content
          setState(() {});
        },
        decoration: new InputDecoration(
            hintText: GoldenConfig.phone,
            labelText: GoldenConfig.userName,
            hintStyle: new TextStyle(fontSize: 12.0, color: Colors.grey)),
        maxLines: 1,
        maxLength: 11,
        //键盘展示为号码
        keyboardType: TextInputType.phone,
        //只能输入数字
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (text) {
          FocusScope.of(context).reparentIfNeeded(node);
        },
      ),
    );
  }

  Widget _buildPasswordEdit() {
    var node = new FocusNode();
    Widget verifyCodeEdit = new TextField(
      onChanged: (str) {
        _password = str;
        setState(() {});
      },
      decoration: new InputDecoration(
          hintText: GoldenConfig.number,
          labelText: GoldenConfig.password,
          hintStyle: new TextStyle(fontSize: 12.0, color: Colors.grey)),
      maxLines: 1,
      maxLength: 6,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).reparentIfNeeded(node);
      },
    );

    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0),
      child: new Stack(
        children: <Widget>[
          verifyCodeEdit,
        ],
      ),
    );
  }

  Widget _buildLogin() {
    return new Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: new RaisedButton(
        padding: new EdgeInsets.fromLTRB(130.0, 10.0, 130.0, 10.0),
        color: GoldenConfig.colorPrimary,
        textColor: Colors.white,
        disabledColor: Colors.blue[500],
        onPressed: (_username.isEmpty || _password.isEmpty)
            ? null
            : () {
//                showTips();
                _login();
              },
        child: new Text(
          GoldenConfig.login,
          style: new TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildTips() {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 40.0, right: 40.0, top: 50.0, bottom: 50.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center, //子组件的排列方式为主轴两端对齐
        children: <Widget>[
          new Image.asset(
            'images/logo.png',
            width: 60.0,
            height: 60.0,
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        _buildTips(),
        _buildUsernameEdit(),
        _buildPasswordEdit(),
        _buildLogin(),
      ],
    );
  }

  showTips() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Container(
              child: new Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: new Text('This is UI Window,not have api',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 24.0))));
        });
  }

  _login() {
    _setUserInfo(HttpExt.login(_username, _password));
  }

  _setUserInfo(Future<Response> responseF) {
    responseF.then((response) {
      var userInfo = LoginModel.fromJson(response.data);
      if (userInfo.errorCode == 0) {
        routePageNavigator(context, setCard(context));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      child: new Scaffold(
//        key: loginKey,
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text(GoldenConfig.githubLogin),
          actions: <Widget>[
            new InkWell(
              child: new Padding(
                padding: EdgeInsets.all(18.0),
                child: new Text(GoldenConfig.otherLogin),
              ),
              onTap: () {
                CommonShare.buildShowBottomPop(context);
              },
            )
          ],
        ),
        //SingleChildScrollView 包裹，否则弹出键盘报bottom overflowed 134px 溢出
        body: new SingleChildScrollView(
          child: _buildBody(),
        ),
      ),
    );
  }
}
