import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furture/service/serviceMethod.dart';
import '../utils/utils.dart';
import '../component/comment.dart';
import 'loginPage.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: new Text(
          "注册",
          textAlign: TextAlign.left,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: new Stack(
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[new RegisterBody()],
      ),
    );
  }
}

class RegisterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //定义文本监听
    TextEditingController _controllerName = new TextEditingController();
    TextEditingController _controllerTel = new TextEditingController();
    TextEditingController _controllerPwd = new TextEditingController();
    TextEditingController _controllerRepwd = new TextEditingController();
    TextEditingController _controllerVerif = new TextEditingController();
    RegExp _name = RegExp(
        r'^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
    RegExp _password = RegExp(
        r'^(?![A-Za-z]+$)(?![A-Z\\d]+$)(?![A-Z\\W]+$)(?![a-z\\d]+$)(?![a-z\\W]+$)(?![\\d\\W]+$)\\S{6,16}$');
    RegExp _phone = RegExp(
        r'^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');

    void sendCode() {
      String _showText = "test";
      bool _ok = false;
      //验证注册
      if (!_name.hasMatch(_controllerName.text.toString())) {
        _showText = "用户名格式不正确";
      } else if (!_phone.hasMatch(_controllerTel.text.toString())) {
        _showText = "手机号格式不正确";
      } else if (!_password.hasMatch(_controllerPwd.text.toString())) {
        _showText = "密码应包含大小写字母，数字，符号中的任意三种";
      } else if (_controllerPwd.text.toString() !=
          _controllerRepwd.text.toString()) {
        _showText = "两次密码不一致";
      } else {
        _ok = true;
      }

      final _snackBar = new SnackBar(
        content: new Text(_showText),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      );
      Scaffold.of(context).showSnackBar(_snackBar);

      if (_ok = true) {
        codeService(_controllerTel.text.toString()).then((onValue) {
          if (onValue['status'] == 'success') {
            //send code
          }
        });
      }
    }

    void testRegister() {
      String _showText = "注册成功！";
      bool _ok = false;
      //验证注册
      if (_controllerVerif.toString() == '') {
        _showText = "请输入验证码";
      }
      registerService(_controllerName.toString(), _controllerPwd.toString(),
              _controllerTel.toString(), _controllerVerif.toString())
          .then((onValue) {
        if (onValue['status'] == 'sucess') {
          _ok = true;
        } else {
          if (onValue['err_msg']) {
            _showText = "验证码错误";
          } else {
            _showText = "注册失败请重新尝试";
          }
        }

        final snackBar = new SnackBar(
          content: new Text(_showText),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(snackBar);

        if (_ok = true) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => route == null);
        }
      });
    }

    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: new Column(
            children: <Widget>[
              TextField(
                controller: _controllerName,
                decoration:
                    InputDecoration(hintText: "用户名", icon: Icon(Icons.book)),
              ),
              TextField(
                controller: _controllerTel,
                decoration:
                    InputDecoration(hintText: "手机号", icon: Icon(Icons.person)),
              ),
              TextField(
                controller: _controllerPwd,
                obscureText: true,
                decoration:
                    InputDecoration(hintText: "密码", icon: Icon(Icons.lock)),
              ),
              TextField(
                controller: _controllerRepwd,
                obscureText: true,
                decoration:
                    InputDecoration(hintText: "重复密码", icon: Icon(Icons.lock)),
              ),
              TextField(
                controller: _controllerVerif,
                decoration: InputDecoration(
                    hintText: "验证码",
                    icon: Icon(Icons.verified_user),
                    suffixIcon: new IconButton(
                        icon: Icon(Icons.send), onPressed: sendCode)),
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
                    child: Text("注册"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      testRegister();
                    },
                  )),
            ],
          ),
        )
      ],
    );
  }
}
