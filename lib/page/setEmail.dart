import 'package:flutter/material.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';

import '../provider/userState.dart';

class SetEmail extends StatefulWidget {
  @override
  _SetEmailState createState() => _SetEmailState();
}

class _SetEmailState extends State<SetEmail> {
  TextEditingController _email = new TextEditingController();
  RegExp _emailReg = RegExp(
      r'^[a-z0-9A-Z]+[- | a-z0-9A-Z . _]+@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-z]{2,}$');
  @override
  void initState() {
    super.initState();
    _email.addListener(() {
      print("邮箱的监听方法：" + _email.text);
    });
  }

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    user.getUserInfo();
    String _showText = "";
    void testSet() async {
      if (_emailReg.hasMatch(_email.text)) {
        final onValue =
        await postUserService(user.email, user.sex, user.nickname);
        if (onValue['status'] == 'success') {
          _showText = "设置成功";
          Navigator.pop(context);
        } else {
          _showText = "设置失败，请检查格式";
        }
      } else {
        _showText = "邮箱格式不正确";
      }
      if (_showText != "设置成功") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  height: 140,
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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("设置邮箱"),
          actions: <Widget>[
            FlatButton(
              color: MyColors.colorWhite,
              child: Text(
                "完成",
                style: TextStyle(
                  color: MyColors.colorBlack,
                ),
              ),
              onPressed: () {
                user.setEmail(_email.text);
                testSet();
              },
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(20.0),
          child: Theme(
            data: ThemeData(
              primaryColor: MyColors.colorBlack,
            ),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                hintText: user.email,
              ),
            ),

          ),
        ),
      ),
    );
  }
}
