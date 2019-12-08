import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../component/comment.dart';
import '../utils/utils.dart';
import 'firstSetColor.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: new Text(
            "用户登录",
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: new ListView(
//        crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[new LoginBody()],
        ),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  LoginBody({Key key}) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  //定义文本监听
  TextEditingController _controllerAcc = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerAcc.addListener(() {
      print("用户的监听方法：" + _controllerAcc.text);
    });
    _controllerPwd.addListener(() {
      print("密码的监听方法：" + _controllerPwd.text);
    });
  }

  @override
  void dispose() {
    _controllerAcc.dispose();
    _controllerPwd.dispose();
    super.dispose();
  }

  //登录提示文本
  String _showText = "正在登录";

  //验证登录
  void testLogin() async {
    if (_controllerAcc.text.toString() == '') {
      _showText = '请输入用户名或手机号';
    } else if (_controllerPwd.text.toString() == '') {
      _showText = "请输入密码";
    } else {
      //获取账户信息
      final onValue = await loginService(
          _controllerAcc.text.toString(), _controllerPwd.text.toString());
      if (onValue['status'] == 'success') {
        _showText = "正在登录";
        Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Text(_showText),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
          ),
        );
        final toColor = await getUserService();
        if (toColor['status'] == 'success') {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomNavigation()),
              (route) => route == null);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => FirstSetColor()),
              (route) => route == null);
        }
        var setUser = await SharedPreferences.getInstance();
        setUser.setString('username', _controllerAcc.text);
        setUser.setString('password', _controllerPwd.text);
      } else {
        if (onValue['err_msg'] == '用户不存在') {
          _showText = "用户不存在";
        } else if (onValue['err_msg'] == '密码不正确') {
          _showText = "密码不正确";
        }
      }
    }
    final _snackBar = new SnackBar(
      content: new Text(_showText),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(_snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: new Column(
            children: <Widget>[
              Gaps.vGap15,
              Gaps.vGap15,
              TextField(
                controller: _controllerAcc,
                decoration: InputDecoration(
                  hintText: "用户名或手机",
                  icon: Icon(Icons.person),
                ),
              ),
              Gaps.vGap15,
              TextFormField(
                controller: _controllerPwd,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "密码",
                  icon: Icon(Icons.lock),
                ),
              ),
              Gaps.vGap15,
              new Row(
                children: <Widget>[
                  Gaps.vGap15,
                  new Expanded(child: Container()),
                  new InkWell(
                    onTap: () {
                      Application.router.navigateTo(context, Routes.register,
                          transition: TransitionType.inFromBottom);
                    },
                    child: Text(
                      "快速注册",
                      style: new TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Gaps.vGap15,
                ],
              ),
              new Container(
                width: 200.0,
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text("登录"),
                  onPressed: () {
                    testLogin();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
