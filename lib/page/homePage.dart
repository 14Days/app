import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:furture/page/homeClass.dart';
import 'package:furture/page/homeFollow.dart';
import 'package:furture/page/homeRecommend.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  //顶部导航列表
  List<Widget> topTabs = [
    new Tab(
      child: Text(
        "推荐",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
    new Tab(
      child: Text(
        "关注",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
    new Tab(
      child: Text(
        "分类",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
      ),
    ),
  ];
  @override
  void initState() {
    _tabController = new TabController(
        vsync: this, //动画效果的异步处理，默认格式
        length: 3 //需要控制的Tab页数量
        );
    super.initState(); //无名无参需要调用
  }

  //当整个页面dispose时，dispose掉控制器，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TabBar(
          tabs: topTabs,
          controller: _tabController,
        ),
      ),
      body: new TabBarView(
        children: <Widget>[
          new HomeRecommend(),
          new HomeFollow(),
          new HomeClass(),
        ],
        controller: _tabController,
      ),
    );
  }
}
