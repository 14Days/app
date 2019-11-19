import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/stateProvider.dart';
import 'package:furture/service/serviceMethod.dart';

class SetNickname extends StatefulWidget {
  @override
  _SetNicknameState createState() => _SetNicknameState();
}

class _SetNicknameState extends State<SetNickname> {
  TextEditingController _nickname = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _nickname.addListener(() {
      print("昵称的监听方法：" + _nickname.text);
    });
  }

  @override
  void dispose() {
    _nickname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context, listen: false);
    user.getUserInfo();
    String _showText = "";
    void testSet() async {
      final onValue =
          await postUserService(user.email, user.sex, user.nickname);
      if (onValue['status'] == 'success') {
        Navigator.pop(context);
      } else {
        _showText = "设置失败，请检查格式";
        final _snackBar = new SnackBar(
          content: new Text(_showText),
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(_snackBar);
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("设置昵称"),
          actions: <Widget>[
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "完成",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                user.setNickname(_nickname.text);
                testSet();
              },
            ),
          ],
        ),
        body: Container(
          child: Container(
            child: TextField(
              controller: _nickname,
              decoration: InputDecoration(
                hintText: user.nickname,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
