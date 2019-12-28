import 'package:flutter/material.dart';
import 'package:furture/provider/messageState.dart';
import 'package:furture/service/serviceMethod.dart';
import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';

import '../provider/userState.dart';

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
    final user = Provider.of<UserState>(context);
    String _showText = "";
    void testSet() async {
      if (_nickname.text == '' || _nickname.text == null) {
        _showText = "昵称不能为空";
      } else {
        final onValue =
            await postUserService(user.email, user.sex, user.nickname);
        if (onValue['status'] == 'success') {
          _showText = "设置成功";
          user.setNickname(_nickname.text);
          Provider.of<MessageState>(context).updateRecommend();
          Provider.of<MessageState>(context).updateFollow();
          Provider.of<MessageState>(context).updateCollect();
          Provider.of<MessageState>(context).updateCategory(
              Provider.of<MessageState>(context).classIndex + 44);
          Navigator.pop(context);
        } else {
          _showText = "设置失败，请检查格式";
        }
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
          title: Text("设置昵称"),
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
                testSet();
              },
            ),
          ],
        ),
        body: Theme(
          data: ThemeData(
            primaryColor: MyColors.colorBlack,
          ),
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _nickname,
              maxLength: 6,
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
