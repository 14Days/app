import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  List<Widget> list = List();

  @override
  void initState() {
    list..add(HomePage())..add(NoticePage())..add(MyPage());
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

    );
  }
}

//推荐类
class SetItem extends StatelessWidget {
  final String item;

  SetItem({Key key, this.item}) : super(key: key);

  //定义单条设置栏目
  Widget _item() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white70,
            border: Border(
              left: BorderSide(width: 0.5, color: Colors.black12),
              right: BorderSide(width: 0.5, color: Colors.black12),
              top: BorderSide(width: 0.5, color: Colors.black12),
              bottom: BorderSide(width: 0.5, color: Colors.black12),
            )),
        child: Text(
          item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _item(),
    );
  }
}
