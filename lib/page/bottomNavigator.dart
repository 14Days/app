import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:furture/component/comment.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget> pages = List();

  @override
  void initState() {
    pages..add(HomePage())..add(NoticePage())..add(MyPage());
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 249, 249, 249),
        //创建底部导航栏
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 0 ? Icons.home : CupertinoIcons.home,
              color: Color.fromARGB(255, 50, 50, 50),
            ),
            title: new Text(
              '首页',
              style: new TextStyle(color: Color.fromARGB(255, 50, 50, 50)),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1? Icons.mail : CupertinoIcons.mail,
              color: Color.fromARGB(255, 50, 50, 50),
            ),
            title: new Text(
              '通知',
              style: new TextStyle(color: Color.fromARGB(255, 50, 50, 50)),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 2 ? Icons.person : CupertinoIcons.person,
              color: Color.fromARGB(255, 50, 50, 50),
            ),
            title: new Text(
              '我的',
              style: new TextStyle(color: Color.fromARGB(255, 50, 50, 50)),
            ),
          ),
        ],
        //这是底部导航栏自带的位标属性。
        currentIndex: _currentIndex,
        //点击属性，会执行带有一个int值的回调函数，这个int值是系统自动返回的你点击的那个标签的位标
        onTap: (int index) {
          //进行状态更新，将系统返回的你点击的标签位标赋予当前位标属性，告诉系统当前要显示的导航标签被用户改变了。
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
    );
  }
}
