import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import '../component/comment.dart';
import 'package:furture/service/serviceMethod.dart';

import '../utils/utils.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
    );
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //定义文本监听
    TextEditingController _controllerAcc = new TextEditingController();
    TextEditingController _controllerPwd = new TextEditingController();

    //登录提示文本
    String _showText = "正在登录";

    void testLogin() {
      //获取账户信息
      loginService(
              _controllerAcc.text.toString(), _controllerPwd.text.toString())
          .then((onValue) {
        print(onValue.toString());
        //验证登录
        if (onValue['status'] == 'success') {
          print("成功登录");
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => BottomNavigation()),
              (route) => route == null);
        } else {
          if (onValue['err_msg'] == '') {
            _showText = "用户名或手机号不能为空";
          } else if (onValue['err_msg']) {
            _showText = "用户不存在";
          } else if (onValue['err_msg']) {
            _showText = "密码错误";
          }
          final _snackBar = new SnackBar(
            content: new Text(_showText),
            backgroundColor: Colors.blue,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 1),
          );
          Scaffold.of(context).showSnackBar(_snackBar);
        }
      });
    }

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
                  new InkWell(
                    onTap: () {
                      Application.router.navigateTo(context, "findPassword",
                          transition: TransitionType.inFromBottom);
                    },
                    child: Text("忘记密码?",
                        style: new TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  new Expanded(child: Container()),
                  new InkWell(
                    onTap: () {
                      Application.router.navigateTo(context, "register",
                          transition: TransitionType.inFromBottom);
                    },
                    child: Text("快速注册",
                        style: new TextStyle(
                          color: Colors.grey,
                        )),
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
                    child: Text("登录"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      testLogin();
                    },
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
