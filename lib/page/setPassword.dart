import 'package:flutter/material.dart';
import 'package:furture/service/serviceMethod.dart';

class SetPassword extends StatefulWidget {
  @override
  _SetPasswordState createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  TextEditingController _old = new TextEditingController();
  TextEditingController _new = new TextEditingController();
  String _showText = "";
  RegExp _password = RegExp(
      r'^(?![a-zA-Z]+$)(?![A-Z0-9]+$)(?![A-Z\W_]+$)(?![a-z0-9]+$)(?![a-z\W_]+$)(?![0-9\W_]+$)[a-zA-Z0-9\W_]{8,16}$');

  @override
  void initState() {
    super.initState();
    _old.addListener(() {
      print("旧密码的监听方法：" + _old.text);
    });
    _new.addListener(() {
      print("新密码的监听方法：" + _new.text);
    });
  }

  @override
  void dispose() {
    _new.dispose();
    _old.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("修改密码"),
          actions: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "完成",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (_old.text == '') {
                  _showText = "请输入旧密码";
                } else if (!_password.hasMatch(_new.text.toString())) {
                  _showText = "密码格式不正确";
                } else {
                  final _onValue = await changePasswordService(
                      _old.text.toString(), _new.text.toString());
                  if (_onValue['status'] == 'success') {
                    _showText = "修改成功!";
                  } else {
                    _showText = "旧密码不正确";
                  }
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          height: 160,
                          width: 190,
                          color:Colors.white,
                          child: Text(
                            _showText,
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 20.0,
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
              },
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _old,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "请输入旧密码",
                ),
              ),
              TextField(
                controller: _new,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "请输入新密码",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "密码应包含大小写字母，数字，符号中的任意三种",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
