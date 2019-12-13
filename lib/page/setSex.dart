import 'package:furture/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/userState.dart';
import 'package:furture/service/serviceMethod.dart';

class SetSex extends StatefulWidget {
  @override
  _SetSexState createState() => _SetSexState();
}

class _SetSexState extends State<SetSex> {
  int _sex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _sex = Provider.of<UserState>(context).sex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserState>(context);
    _sex = user.sex;
    Widget sexForm() {
      return new StatefulBuilder(
        builder: (
          context,
          StateSetter setState,
        ) {
          return Row(
            children: <Widget>[
              Flexible(
                child: RadioListTile<int>(
                  value: 0,
                  activeColor: MyColors.colorOrange,
                  groupValue: _sex,
                  title: Text("男"),
                  onChanged: (value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
              ),
              Flexible(
                child: RadioListTile<int>(
                  value: 1,
                  activeColor: MyColors.colorOrange,
                  groupValue: _sex,
                  title: Text("女"),
                  onChanged: (value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    void testSet() async {
      final onValue =
          await postUserService(user.email, user.sex, user.nickname);
      if (onValue['status'] == 'success') {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置性别"),
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
              user.setSex(_sex);
              testSet();
            },
          ),
        ],
      ),
      body: Container(
        child: sexForm(),
      ),
    );
  }
}
