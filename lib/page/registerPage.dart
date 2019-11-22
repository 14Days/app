import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furture/service/serviceMethod.dart';
import '../component/comment.dart';
import 'loginPage.dart';

class RegisterPage extends StatelessWidget {
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
      ),
    );
  }
}

class RegisterBody extends StatefulWidget {
  @override
  _RegisterBodyState createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  //定义文本监听
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerTel = new TextEditingController();
  TextEditingController _controllerPwd = new TextEditingController();
  TextEditingController _controllerRepwd = new TextEditingController();
  TextEditingController _controllerVerif = new TextEditingController();
  RegExp _name = RegExp(r'^(?![\u4e00-\u9fa5])');
  RegExp _password = RegExp(
      r'^(?![a-zA-Z]+$)(?![A-Z0-9]+$)(?![A-Z\W_]+$)(?![a-z0-9]+$)(?![a-z\W_]+$)(?![0-9\W_]+$)[a-zA-Z0-9\W_]{8,16}$');
  RegExp _phone = RegExp(r'^1[35678]\d{9}$');

  @override
  void initState() {
    super.initState();
    _controllerName.addListener(() {
      print("用户的监听方法：" + _controllerName.text);
    });
    _controllerPwd.addListener(() {
      print("密码的监听方法：" + _controllerPwd.text);
    });
    _controllerTel.addListener(() {
      print("电话的监听方法：" + _controllerTel.text);
    });
    _controllerRepwd.addListener(() {
      print("重复密码的监听方法：" + _controllerRepwd.text);
    });
    _controllerVerif.addListener(() {
      print("验证码的监听方法：" + _controllerVerif.text);
    });
  }

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerPwd.dispose();
    _controllerTel.dispose();
    _controllerRepwd.dispose();
    _controllerVerif.dispose();
    super.dispose();
  }

  void sendCode() async {
    String _showText = "111";
    //验证注册
    if (!_name.hasMatch(_controllerName.text.toString())) {
      _showText = "用户名不能为中文";
    } else if (!_phone.hasMatch(_controllerTel.text.toString())) {
      _showText = "手机号格式不正确";
    } else if (!_password.hasMatch(_controllerPwd.text.toString())) {
      _showText = "密码应包含大小写字母，数字，符号中的任意三种";
    } else if (_controllerPwd.text.toString() !=
        _controllerRepwd.text.toString()) {
      _showText = "两次密码不一致";
    } else {
      final onValue = await codeService(_controllerTel.text.toString());
      if (onValue['status'] == 'success') {
        _showText = "验证码已发送";
      } else {
        if (onValue['err_msg'] == '手机号已存在') {
          _showText = "手机号已存在";
          print(_showText);
        } else {
          _showText = "发送失败,请稍后尝试";
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

  void testRegister() async {
    String _showText = "开始注册";
    bool _ok = false;
    //验证注册
    if (_controllerVerif.text.toString() == '') {
      _showText = "请输入验证码";
    } else {
      final onValue = await registerService(
          _controllerName.text.toString(),
          _controllerPwd.text.toString(),
          _controllerTel.text.toString(),
          _controllerVerif.text.toString());
      if (onValue['status'] == 'success') {
        _ok = true;
      } else {
        if (onValue['err_msg'] == '验证码错误') {
          _showText = "验证码错误";
        } else if (onValue['err_msg'] == "用户名已存在") {
          _showText = "用户名已存在";
        } else {
          _showText = "注册失败请重新尝试";
        }
      }
    }

    final snackBar = new SnackBar(
      content: new Text(_showText),
      backgroundColor: Colors.blue,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
    );
    Scaffold.of(context).showSnackBar(snackBar);

    if (_ok == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => route == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: new Column(
            children: <Widget>[
              TextField(
                controller: _controllerName,
                decoration:
                    InputDecoration(hintText: "用户名", icon: Icon(Icons.person)),
              ),
              TextField(
                controller: _controllerTel,
                decoration:
                    InputDecoration(hintText: "手机号", icon: Icon(Icons.phone)),
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
