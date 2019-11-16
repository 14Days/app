import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';

class SetPage extends StatefulWidget {
  @override
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState(); //无名无参需要调用
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    super.dispose();
  }

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
              child: SetItem(),
            ),
            new Container(
                width: double.infinity,
                height: 50.0,
                margin: EdgeInsets.only(bottom: 0),
                child: RaisedButton(
                  color: Colors.blue,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text(
                    "退出登录",
                    style: TextStyle(),
                  ),
                  onPressed: () {
                    LoginPage();
                  },
                )),
          ],
        ));
  }
}

//设置条目
class SetItem extends StatelessWidget {
  final List<String> items = ['头像', '昵称', '手机', '颜色'];

  //定义单条设置栏目
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 5.0, left: 10.0),
        padding: const EdgeInsets.all(10.0),
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
            new IconButton(
              icon: Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 30.0,
              ),
              onPressed: () {},
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
          return Material(child: _item(index));
        });
  }
}
