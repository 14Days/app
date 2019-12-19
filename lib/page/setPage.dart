import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';
import 'package:furture/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/serviceMethod.dart';

class SetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("设置"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5.0),
              child: SetItems(),
            ),
          ),
          new Logout(),
        ],
      ),
    );
  }
}

//退出登录
class Logout extends StatefulWidget {
  @override
  _LogoutState createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  //退出登录
  void testLogout() async {
    final onValue = await logoutService();
    if (onValue['status'] == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => route == null);
      var setUser = await SharedPreferences.getInstance();
      setUser.setString('username', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: 50.0,
      child: RaisedButton(
        color: Color.fromARGB(255, 254, 254, 254),
        highlightColor: Colors.transparent,
        colorBrightness: Brightness.dark,
        splashColor: Colors.grey,
        child: Text(
          "退出登录",
          style: TextStyle(
            color: MyColors.colorOrange,
          ),
        ),
        onPressed: () {
          testLogout();
        },
      ),
    );
  }
}

//设置条目
class SetItems extends StatefulWidget {
  @override
  _SetItemsState createState() => _SetItemsState();
}

class _SetItemsState extends State<SetItems> {
  final List<String> items = ['头像', '昵称', '性别', '邮箱', '颜色', '修改密码'];

  //定义单条设置栏目
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            {
              Application.router.navigateTo(context, Routes.setAvatar,
                  transition: TransitionType.cupertino);
            }
            break;
          case 1:
            {
              Application.router.navigateTo(context, Routes.setNickname,
                  transition: TransitionType.cupertino);
            }
            break;
          case 2:
            {
              Application.router.navigateTo(context, Routes.setSex,
                  transition: TransitionType.cupertino);
            }
            break;
          case 3:
            {
              Application.router.navigateTo(context, Routes.setEmail,
                  transition: TransitionType.cupertino);
            }
            break;
          case 4:
            {
              Application.router.navigateTo(context, Routes.setColor,
                  transition: TransitionType.cupertino);
            }
            break;
          case 5:
            {
              Application.router.navigateTo(context, Routes.setPassword,
                  transition: TransitionType.cupertino);
            }
            break;
        }
      },
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(top: 2.0),
        padding: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
              right: BorderSide(width: 0.5, color: Colors.black12),
              top: BorderSide(width: 0.5, color: Colors.black12),
              bottom: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Row(
          children: <Widget>[
            new Text(
              items[index],
              style: TextStyle(),
            ),
            new Expanded(
              child: Container(),
            ),
            new Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Material(child: _item(context, index));
      },
    );
  }
}
