import 'dart:async';

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
          backgroundColor: MyColors.colorWhite,
          title: new Text(
            "I deer",
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 27,
              color: MyColors.colorBlack,
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

//定义变量
  Timer _timer;

  //倒计时数值
  var countdownTime = 0;

  //倒计时方法
  startCountdown() {
    countdownTime = 3;
    final call = (timer) {
      setState(() {
        if (countdownTime < 1) {
          _timer.cancel();
        } else {
          countdownTime -= 1;
        }
      });
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

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
    if (_timer != null) {
      _timer.cancel();
    }
    _controllerAcc.dispose();
    _controllerPwd.dispose();
    super.dispose();
  }

  //登录提示文本
  String _showText = "开始登录";

  //验证登录
  void testLogin() async {
    startCountdown();
    if (_controllerAcc.text.toString() == '') {
      _showText = '请输入用户名';
    } else if (_controllerPwd.text.toString() == '') {
      _showText = "请输入密码";
    } else {
      //获取账户信息
      final onValue = await loginService(
          _controllerAcc.text.toString(), _controllerPwd.text.toString());
      if (onValue['status'] == 'success') {
        _showText = "正在登录";
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
    if (_showText != "正在登录") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                height: 120,
                width: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: Text(
                  _showText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 17.0,
                    fontFamily: "Rock Salt",
                    fontWeight: FontWeight.w100,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
          decoration: BoxDecoration(
            color: MyColors.colorWhite,
          ),
          child: new Column(
            children: <Widget>[
              Gaps.vGap15,
              Gaps.vGap15,
              Theme(
                data: ThemeData(
                  primaryColor: MyColors.colorBlack,
                ),
                child: TextField(
                  controller: _controllerAcc,
                  cursorColor: MyColors.colorBlack,
                  decoration: InputDecoration(
                    hintText: "用户名",
                    icon: Icon(
                      Icons.person,
                    ),
                  ),
                ),
              ),
              Gaps.vGap15,
              Theme(
                data: ThemeData(
                  primaryColor: MyColors.colorBlack,
                ),
                child: TextFormField(
                  controller: _controllerPwd,
                  obscureText: true,
                  cursorColor: MyColors.colorBlack,
                  decoration: InputDecoration(
                    hintText: "密码",
                    icon: Icon(Icons.lock),
                  ),
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
                  color: MyColors.colorWhite,
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    "登录",
                    style: TextStyle(
                      color: MyColors.colorOrange,
                    ),
                  ),
                  onPressed: () {
                    if (countdownTime == 0) {
                      testLogin();
                    }
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
