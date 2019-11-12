import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';

class NoticePage extends StatefulWidget {
  @override
  _NoticePageState createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 1;
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
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(
          "通知",
        ),
      ),
      body: new ListView(),
    );
  }
}
